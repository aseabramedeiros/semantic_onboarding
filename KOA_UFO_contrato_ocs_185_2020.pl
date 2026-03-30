% ===== KOA Combined Output | contract_id: contrato_ocs_185_2020 =====

% ===== 1) UFO Ontology =====
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY EM PROLOG
% Inspirada em UFO-L + UFO-S + Service Contract Ontology (Griffo et al., 2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META-ESTRUTURA (TBox: classes, especializações, relações entre classes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicados básicos de metamodelo
class(C).          % C é uma classe ontológica
subclass_of(C, P). % C é subclasse de P
disjoint(C1, C2).  % C1 e C2 são disjuntas conceitualmente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Núcleo UFO-A / UFO-C simplificado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(agent).           % agente (pessoa, organização etc.)
class(relator).         % relator genérico
class(moment).          % propriedade/momento (trope no sentido do UFO)

class(social_relator).
class(legal_relator).

subclass_of(social_relator, relator).
subclass_of(legal_relator, social_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEGAL MOMENTS E LEGAL RELATORS (UFO-L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(legal_moment).
class(legal_entitlement).      % vantagens jurídicas
class(legal_burden_or_lack).  % ônus / falta de prerrogativa

subclass_of(legal_entitlement, legal_moment).
subclass_of(legal_burden_or_lack, legal_moment).

% Tipos de legal relators
class(simple_legal_relator).
class(complex_legal_relator).

subclass_of(simple_legal_relator, legal_relator).
subclass_of(complex_legal_relator, legal_relator).

% ---------------------------------------------------------------------------
% Right / Duty
% ---------------------------------------------------------------------------

class(right).
class(right_to_action).
class(right_to_omission).

class(duty).
class(duty_to_act).
class(duty_to_omit).

subclass_of(right, legal_entitlement).
subclass_of(right_to_action, right).
subclass_of(right_to_omission, right).

subclass_of(duty, legal_burden_or_lack).
subclass_of(duty_to_act, duty).
subclass_of(duty_to_omit, duty).

% ---------------------------------------------------------------------------
% NoRight / Permission
% ---------------------------------------------------------------------------

class(no_right).
class(no_right_to_action).
class(no_right_to_omission).

class(permission).
class(permission_to_act).
class(permission_to_omit).

subclass_of(no_right, legal_burden_or_lack).
subclass_of(no_right_to_action, no_right).
subclass_of(no_right_to_omission, no_right).

subclass_of(permission, legal_entitlement).
subclass_of(permission_to_act, permission).
subclass_of(permission_to_omit, permission).

% ---------------------------------------------------------------------------
% Power / Subjection (Liability)
% ---------------------------------------------------------------------------

class(power).
class(subjection).

subclass_of(power, legal_entitlement).
subclass_of(subjection, legal_burden_or_lack).

% ---------------------------------------------------------------------------
% Disability / Immunity
% ---------------------------------------------------------------------------

class(disability).
class(immunity).

subclass_of(disability, legal_burden_or_lack).
subclass_of(immunity, legal_entitlement).

% ---------------------------------------------------------------------------
% Liberty (liberdade desprotegida como complex legal relator)
% ---------------------------------------------------------------------------

class(liberty_relator).
subclass_of(liberty_relator, complex_legal_relator).

% ---------------------------------------------------------------------------
% Tipos de Simple Legal Relator (pares correlatos)
% ---------------------------------------------------------------------------

class(right_duty_relator).
class(noright_permission_relator).
class(power_subjection_relator).
class(disability_immunity_relator).

subclass_of(right_duty_relator, simple_legal_relator).
subclass_of(noright_permission_relator, simple_legal_relator).
subclass_of(power_subjection_relator, simple_legal_relator).
subclass_of(disability_immunity_relator, simple_legal_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELAÇÃO ENTRE LEGAL MOMENTS (Hohfeld + Alexy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correlatos em nível de classe
correlates(right_to_action,   duty_to_act).
correlates(duty_to_act,       right_to_action).

correlates(right_to_omission, duty_to_omit).
correlates(duty_to_omit,      right_to_omission).

correlates(permission_to_act,     no_right_to_action).
correlates(no_right_to_action,    permission_to_act).

correlates(permission_to_omit,    no_right_to_omission).
correlates(no_right_to_omission,  permission_to_omit).

correlates(power,      subjection).
correlates(subjection, power).

correlates(disability, immunity).
correlates(immunity,   disability).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE RELATIONS E SERVICE CONTRACTS (núcleo UFO-S simplificado)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(service_relation).
class(service_agreement).
class(legal_service_agreement).

subclass_of(service_agreement, service_relation).
subclass_of(legal_service_agreement, service_agreement).

% Papéis em relações de serviço
class(service_provider_role).
class(target_customer_role).
class(hired_service_provider_role).
class(service_customer_role).

subclass_of(hired_service_provider_role, service_provider_role).
subclass_of(service_customer_role,       target_customer_role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY (Fig. 4 do artigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Em um Legal Service Agreement, cada parte tem Entitlements e Burdens/Lacks
class(hsp_entitlement).      % Hired Service Provider Entitlement
class(hsp_burden_or_lack).   % Hired Service Provider Burden/Lack
class(sc_entitlement).       % Service Customer Entitlement
class(sc_burden_or_lack).    % Service Customer Burden/Lack

subclass_of(hsp_entitlement, legal_entitlement).
subclass_of(sc_entitlement,  legal_entitlement).

subclass_of(hsp_burden_or_lack, legal_burden_or_lack).
subclass_of(sc_burden_or_lack,  legal_burden_or_lack).

% Composição: um Legal Service Agreement é composto de legal moments
% associados a cada papel (provider x customer).
relator_component(legal_service_agreement, hsp_entitlement).
relator_component(legal_service_agreement, hsp_burden_or_lack).
relator_component(legal_service_agreement, sc_entitlement).
relator_component(legal_service_agreement, sc_burden_or_lack).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESQUEMA PARA INSTÂNCIAS (ABox): AGENTES, ACORDOS, CLÁUSULAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instance_of(Instancia, Classe).
% Você vai usar isso para criar indivíduos (contratos, cláusulas, agentes...).

:- dynamic instance_of/2.
:- dynamic plays_role/3.
:- dynamic legal_relation_instance/4.
:- dynamic clause_of/2.

% plays_role(Agente, Papel, Acordo).
% Ex.: plays_role(aws, hired_service_provider_role, aws_sns_agreement).
%      plays_role(cliente_x, service_customer_role, aws_sns_agreement).
plays_role(Agent, Role, Agreement).

% clause_of(ClauseId, Agreement).
% ClauseId é uma cláusula (ou grupo de cláusulas) de um acordo específico.
clause_of(ClauseId, Agreement).

% legal_relation_instance(ClauseId, LegalMoment, Bearer, Action).
%
% ClauseId   - identificador da cláusula
% LegalMoment- classe do momento jurídico (duty_to_omit, power, immunity...)
% Bearer     - quem tem esse momento (agente ou papel)
% Action     - ação/omissão ou descrição da conduta
%
% Exemplos (para você popular depois, inspirados no artigo):
% legal_relation_instance(clause_17_1, duty_to_omit, customer, share_service_with_third_parties).
% legal_relation_instance(clause_17_1, right_to_omission, provider, share_service_with_third_parties).

legal_relation_instance(ClauseId, LegalMomentClass, Bearer, Action) :-
    clause_of(ClauseId, _Agreement),
    class(LegalMomentClass),
    (   atom(Bearer)
    ;   plays_role(Bearer, _, _)
    ),
    atom(Action).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGRAS AUXILIARES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fecho transitivo de subclass_of/2
subclass_of_trans(C, P) :-
    subclass_of(C, P).
subclass_of_trans(C, P) :-
    subclass_of(C, X),
    subclass_of_trans(X, P).

% is_a(Inst, Classe) — verifica se Inst é instância (direta ou indireta) de Classe
is_a(Inst, Classe) :-
    instance_of(Inst, C0),
    (   C0 = Classe
    ;   subclass_of_trans(C0, Classe)
    ).

% um legal_moment é um entitlement se a classe dele cai abaixo de legal_entitlement
is_entitlement(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_entitlement).

% um legal_moment é um burden/lack se cai abaixo de legal_burden_or_lack
is_burden_or_lack(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_burden_or_lack).

% Dado um LegalMomentClass, encontrar seu correlato (em termos de classe)
correlative_class(LMClass, CorrelateClass) :-
    correlates(LMClass, CorrelateClass).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM DA ONTOLOGIA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ===== 2) Generated UFO ABox =====
% UFO-only grounding generated from: KOA_Contrato_OCS_185_2020_-_Tecno-IT_(CFTV).pl
% contract_id: contrato_ocs_185_2020

instance_of(contrato_ocs_185_2020, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(tecno_it_tecnologia_servicos_e_comunicacao_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_185_2020).
plays_role(tecno_it_tecnologia_servicos_e_comunicacao_ltda, hired_service_provider_role, contrato_ocs_185_2020).

clause_of(clausula_primeira_objeto, contrato_ocs_185_2020).
clause_of(clausula_segunda_vigencia, contrato_ocs_185_2020).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_185_2020).
clause_of(clausula_quarta_recebimento_objeto, contrato_ocs_185_2020).
clause_of(clausula_quinta_preco, contrato_ocs_185_2020).
clause_of(clausula_sexta_pagamento, contrato_ocs_185_2020).
clause_of(clausula_setima_equilibrio_economico_financeiro_contrato, contrato_ocs_185_2020).
clause_of(clausula_oitava_matriz_riscos, contrato_ocs_185_2020).
clause_of(clausula_nona_garantia_contratual, contrato_ocs_185_2020).
clause_of(clausula_decima_obrigações_contratado, contrato_ocs_185_2020).
clause_of(clausula_decima_primeira_conduta_etica_contratado_bndes, contrato_ocs_185_2020).
clause_of(clausula_decima_segunda_sigilo_informacoes, contrato_ocs_185_2020).
clause_of(clausula_decima_terceira_obrigações_bndes, contrato_ocs_185_2020).
clause_of(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, contrato_ocs_185_2020).
clause_of(clausula_decima_quinta_penalidades, contrato_ocs_185_2020).
clause_of(clausula_decima_sexta_alterações_contratuais, contrato_ocs_185_2020).
clause_of(clausula_decima_setima_extinção_contrato, contrato_ocs_185_2020).
clause_of(clausula_decima_oitava_disposições_finais, contrato_ocs_185_2020).
clause_of(clausula_decima_nona_foro, contrato_ocs_185_2020).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, provide_video_surveillance_services).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_video_surveillance_services).
legal_relation_instance(clausula_primeira_objeto, right_to_action, tecno_it_tecnologia_servicos_e_comunicacao_ltda, receive_payment_for_video_surveillance).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, maintain_contract_for_60_months).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_contract_to_be_maintained).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, execute_contracted_object).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_executed_contracted_object).
legal_relation_instance(clausula_quarta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effectuate_object_acceptance).
legal_relation_instance(clausula_quarta_recebimento_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_object).
legal_relation_instance(clausula_quarta_recebimento_objeto, duty_to_act, unknown, manage_object_acceptance).
legal_relation_instance(clausula_quinta_preco, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, complement_quantities).
legal_relation_instance(clausula_quinta_preco, subjection, tecno_it_tecnologia_servicos_e_comunicacao_ltda, bear_costs_of_estimation_error).
legal_relation_instance(clausula_quinta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_value).
legal_relation_instance(clausula_quinta_preco, right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_indemnification_for_total_demand).
legal_relation_instance(clausula_quinta_preco, no_right_to_action, tecno_it_tecnologia_servicos_e_comunicacao_ltda, bring_action_for_total_object_not_demanded).
legal_relation_instance(clausula_quinta_preco, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, partially_execute_and_receive_object).
legal_relation_instance(clausula_sexta_pagamento, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, send_fiscal_document).
legal_relation_instance(clausula_sexta_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_fiscal_document).
legal_relation_instance(clausula_sexta_pagamento, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_from_invoice).
legal_relation_instance(clausula_sexta_pagamento, subjection, tecno_it_tecnologia_servicos_e_comunicacao_ltda, be_subject_to_deduction).
legal_relation_instance(clausula_sexta_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payment).
legal_relation_instance(clausula_sexta_pagamento, right_to_action, tecno_it_tecnologia_servicos_e_comunicacao_ltda, receive_payment).
legal_relation_instance(clausula_sexta_pagamento, permission_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_payment_if_divergences).
legal_relation_instance(clausula_sexta_pagamento, duty_to_omit, tecno_it_tecnologia_servicos_e_comunicacao_ltda, omit_sending_invoice_with_errors).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, right_to_action, tecno_it_tecnologia_servicos_e_comunicacao_ltda, request_price_readjustment).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, right_to_action, tecno_it_tecnologia_servicos_e_comunicacao_ltda, request_price_revision).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, convene_for_price_reduction).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_price_adjustment).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, request_price_adjustment_before_end).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, present_info_price_reduction).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, immunity, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_price_review).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, negotiate_price_post_readjustment).
legal_relation_instance(clausula_setima_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, rescind_contract_post_readjustment).
legal_relation_instance(clausula_oitava_matriz_riscos, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, identify_risks).
legal_relation_instance(clausula_oitava_matriz_riscos, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, establish_risk_responsibilities).
legal_relation_instance(clausula_nona_garantia_contratual, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, provide_contractual_guarantee).
legal_relation_instance(clausula_nona_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_contractual_guarantee).
legal_relation_instance(clausula_nona_garantia_contratual, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, complement_or_substitute_guarantee).
legal_relation_instance(clausula_nona_garantia_contratual, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, obtain_guarantor_consent).
legal_relation_instance(clausula_nona_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_guarantee_presentation_period).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, maintain_qualification_conditions).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, inform_penalty_imposition).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, repair_replace_contract_object).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, repair_damages).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, pay_taxes).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, provide_exclusion_proof).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, allow_inspection).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, obey_instructions).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, designate_representative).
legal_relation_instance(clausula_decima_obrigações_contratado, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, submit_dif).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, maintain_integrity_public_private).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_omit, tecno_it_tecnologia_servicos_e_comunicacao_ltda, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_omit, tecno_it_tecnologia_servicos_e_comunicacao_ltda, prevent_employee_favoritism).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_omit, tecno_it_tecnologia_servicos_e_comunicacao_ltda, prevent_allocation_of_family_members).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, observe_code_of_ethics).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, adopt_good_environmental_practices).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, prevent_corruption).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, remove_agents_from_contract).
legal_relation_instance(clausula_decima_primeira_conduta_etica_contratado_bndes, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, communicate_situations_to_bndes).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, maintain_confidentiality).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, provide_confidentiality_agreement).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, orient_professionals_to_comply).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_confidentiality_agreement).
legal_relation_instance(clausula_decima_segunda_sigilo_informacoes, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, respect_bndes_security_policy).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contracted).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_info_available_to_contracted).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, replace_contract_manager).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_documents_to_contracted).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions_to_contracted).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_investigation_to_contracted).
legal_relation_instance(clausula_decima_terceira_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty_to_contracted).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, tecno_it_tecnologia_servicos_e_comunicacao_ltda, omit_contract_assignment).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, tecno_it_tecnologia_servicos_e_comunicacao_ltda, assign_contract).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, tecno_it_tecnologia_servicos_e_comunicacao_ltda, omit_credit_assignment).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, tecno_it_tecnologia_servicos_e_comunicacao_ltda, assign_credit).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, duty_to_omit, tecno_it_tecnologia_servicos_e_comunicacao_ltda, omit_credit_title_emission).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, no_right_to_action, tecno_it_tecnologia_servicos_e_comunicacao_ltda, emit_credit_title).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, properly_execute_agreement).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyse_risks_succession).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_risks_subcontracting).
legal_relation_instance(clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, duty_to_act, tecno_it_tecnologia_servicos_e_comunicacao_ltda, present_supporting_docs_subcontracting).
legal_relation_instance(clausula_decima_quinta_penalidades, subjection, tecno_it_tecnologia_servicos_e_comunicacao_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_quinta_penalidades, duty_to_omit, tecno_it_tecnologia_servicos_e_comunicacao_ltda, omit_total_or_partial_breach).
legal_relation_instance(clausula_decima_quinta_penalidades, right_to_action, tecno_it_tecnologia_servicos_e_comunicacao_ltda, defend_prior).
legal_relation_instance(clausula_decima_quinta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_warning).
legal_relation_instance(clausula_decima_quinta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_fine_up_to_20_percent).
legal_relation_instance(clausula_decima_quinta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_fine_up_to_10_percent).
legal_relation_instance(clausula_decima_quinta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, temporarily_suspend_participation).
legal_relation_instance(clausula_decima_quinta_penalidades, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, ensure_right_of_defense).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, compensate_damages_from_refusal).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, not_denature_contract_object).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, denature_contract_object).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, not_affect_essential_conditions).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, affect_essential_conditions).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, agree_to_contract_alteration).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, be_liable_for_damages).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_alteration).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, no_right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, not_refuse_to_formalize_contract_alteration).
legal_relation_instance(clausula_decima_sexta_alterações_contratuais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_contract_alteration).
legal_relation_instance(clausula_decima_setima_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_other_party_of_breach).
legal_relation_instance(clausula_decima_setima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_execution_of_contract).
legal_relation_instance(clausula_decima_setima_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_written_notification).
legal_relation_instance(clausula_decima_setima_extinção_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_opportunity_of_defense).
legal_relation_instance(clausula_decima_setima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_setima_extinção_contrato, subjection, tecno_it_tecnologia_servicos_e_comunicacao_ltda, be_subject_to_bndes_suspension).
legal_relation_instance(clausula_decima_setima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_for_insolvency).
legal_relation_instance(clausula_decima_setima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_for_loss_of_qualification).
legal_relation_instance(clausula_decima_setima_extinção_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_for_unjustified_delay).
legal_relation_instance(clausula_decima_setima_extinção_contrato, right_to_action, tecno_it_tecnologia_servicos_e_comunicacao_ltda, receive_written_notification).
legal_relation_instance(clausula_decima_oitava_disposições_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights).
legal_relation_instance(clausula_decima_oitava_disposições_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, establish_waiver_or_novation).
legal_relation_instance(clausula_decima_nona_foro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, choose_rio_de_janeiro_court).
legal_relation_instance(clausula_decima_nona_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, choose_other_court).

% --- Action catalog (local to this contract grounding) ---
action_type(adopt_good_environmental_practices).
action_label(adopt_good_environmental_practices, 'Adopt good environmental practices').
action_type(affect_essential_conditions).
action_label(affect_essential_conditions, 'Affect essential conditions').
action_type(agree_to_contract_alteration).
action_label(agree_to_contract_alteration, 'Agree to contract alteration').
action_type(allow_inspection).
action_label(allow_inspection, 'Allow inspection').
action_type(analyse_risks_succession).
action_label(analyse_risks_succession, 'Analyze succession risks').
action_type(analyze_price_adjustment).
action_label(analyze_price_adjustment, 'Analyze price adjustment request').
action_type(analyze_risks_subcontracting).
action_label(analyze_risks_subcontracting, 'Analyze risks of subcontracting').
action_type(apply_fine_up_to_10_percent).
action_label(apply_fine_up_to_10_percent, 'Apply fine up to 10%').
action_type(apply_fine_up_to_20_percent).
action_label(apply_fine_up_to_20_percent, 'Apply fine up to 20%').
action_type(apply_warning).
action_label(apply_warning, 'Apply warning').
action_type(assign_contract).
action_label(assign_contract, 'No right to assign contract').
action_type(assign_credit).
action_label(assign_credit, 'No right to assign credit').
action_type(be_liable_for_damages).
action_label(be_liable_for_damages, 'Be liable for damages').
action_type(be_subject_to_bndes_suspension).
action_label(be_subject_to_bndes_suspension, 'Subject to BNDES suspension').
action_type(be_subject_to_deduction).
action_label(be_subject_to_deduction, 'Be subject to deduction').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(bear_costs_of_estimation_error).
action_label(bear_costs_of_estimation_error, 'Bear costs of estimation error').
action_type(bring_action_for_total_object_not_demanded).
action_label(bring_action_for_total_object_not_demanded, 'No indemnification for total object not demanded').
action_type(choose_other_court).
action_label(choose_other_court, 'Choose other court').
action_type(choose_rio_de_janeiro_court).
action_label(choose_rio_de_janeiro_court, 'Choose Rio court').
action_type(communicate_instructions_to_contracted).
action_label(communicate_instructions_to_contracted, 'Communicate instructions to contracted').
action_type(communicate_investigation_to_contracted).
action_label(communicate_investigation_to_contracted, 'Communicate investigation to contracted').
action_type(communicate_penalty_to_contracted).
action_label(communicate_penalty_to_contracted, 'Communicate penalty to contracted').
action_type(communicate_situations_to_bndes).
action_label(communicate_situations_to_bndes, 'Communicate situations to BNDES').
action_type(compensate_damages_from_refusal).
action_label(compensate_damages_from_refusal, 'Compensate damages from refusal').
action_type(complement_or_substitute_guarantee).
action_label(complement_or_substitute_guarantee, 'Complement/substitute guarantee').
action_type(complement_quantities).
action_label(complement_quantities, 'Complement quantities').
action_type(convene_for_price_reduction).
action_label(convene_for_price_reduction, 'Convene to negotiate price reduction').
action_type(deduct_from_invoice).
action_label(deduct_from_invoice, 'Deduct from invoice').
action_type(defend_prior).
action_label(defend_prior, 'Defend prior').
action_type(demand_contract_alteration).
action_label(demand_contract_alteration, 'Demand contract alteration').
action_type(demand_proof_of_tax_regularity).
action_label(demand_proof_of_tax_regularity, 'Demand proof of tax regularity').
action_type(denature_contract_object).
action_label(denature_contract_object, 'Denature contract object').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(effectuate_object_acceptance).
action_label(effectuate_object_acceptance, 'Effectuate object acceptance').
action_type(emit_credit_title).
action_label(emit_credit_title, 'No right to emit credit title').
action_type(ensure_right_of_defense).
action_label(ensure_right_of_defense, 'Ensure right of defense').
action_type(ensure_security_compliance).
action_label(ensure_security_compliance, 'Ensure security compliance').
action_type(establish_risk_responsibilities).
action_label(establish_risk_responsibilities, 'Establish risk responsibilities').
action_type(establish_waiver_or_novation).
action_label(establish_waiver_or_novation, 'Establish waiver/novation').
action_type(execute_contracted_object).
action_label(execute_contracted_object, 'Execute contracted object').
action_type(exercise_rights).
action_label(exercise_rights, 'Exercise rights').
action_type(expect_contract_to_be_maintained).
action_label(expect_contract_to_be_maintained, 'Expect contract to be maintained').
action_type(extend_guarantee_presentation_period).
action_label(extend_guarantee_presentation_period, 'Extend guarantee presentation period').
action_type(formalize_contract_alteration).
action_label(formalize_contract_alteration, 'Formalize contract alteration').
action_type(grant_acquiescence_subcontracting).
action_label(grant_acquiescence_subcontracting, 'Grant acquiescence for subcontracting').
action_type(grant_acquiescence_succession).
action_label(grant_acquiescence_succession, 'Grant acquiescence for succession').
action_type(identify_risks).
action_label(identify_risks, 'Identify risks').
action_type(inform_penalty_imposition).
action_label(inform_penalty_imposition, 'Inform penalty imposition').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality').
action_type(maintain_contract_for_60_months).
action_label(maintain_contract_for_60_months, 'Maintain contract for 60 months').
action_type(maintain_integrity_public_private).
action_label(maintain_integrity_public_private, 'Maintain integrity in relations').
action_type(maintain_qualification_conditions).
action_label(maintain_qualification_conditions, 'Maintain qualification conditions').
action_type(make_info_available_to_contracted).
action_label(make_info_available_to_contracted, 'Make info available to contracted').
action_type(make_payment).
action_label(make_payment, 'Make payment').
action_type(make_payments_to_contracted).
action_label(make_payments_to_contracted, 'Make payments to contracted party').
action_type(manage_object_acceptance).
action_label(manage_object_acceptance, 'Manage object acceptance').
action_type(negotiate_price_post_readjustment).
action_label(negotiate_price_post_readjustment, 'Negotiate price post-readjustment').
action_type(not_affect_essential_conditions).
action_label(not_affect_essential_conditions, 'Not affect essential conditions').
action_type(not_denature_contract_object).
action_label(not_denature_contract_object, 'Not denature contract object').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Not offer undue advantage').
action_type(not_refuse_to_formalize_contract_alteration).
action_label(not_refuse_to_formalize_contract_alteration, 'Not refuse to formalize contract alteration').
action_type(notify_other_party_of_breach).
action_label(notify_other_party_of_breach, 'Notify party of breach').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_code_of_ethics).
action_label(observe_code_of_ethics, 'Observe code of ethics').
action_type(obtain_guarantor_consent).
action_label(obtain_guarantor_consent, 'Obtain guarantor consent').
action_type(omit_contract_assignment).
action_label(omit_contract_assignment, 'Omit contract assignment').
action_type(omit_credit_assignment).
action_label(omit_credit_assignment, 'Omit credit assignment').
action_type(omit_credit_title_emission).
action_label(omit_credit_title_emission, 'Omit credit title emission').
action_type(omit_indemnification_for_total_demand).
action_label(omit_indemnification_for_total_demand, 'Omit indemnification').
action_type(omit_payment_if_divergences).
action_label(omit_payment_if_divergences, 'Omit payment if divergences').
action_type(omit_sending_invoice_with_errors).
action_label(omit_sending_invoice_with_errors, 'Omit sending invoice with errors').
action_type(omit_total_or_partial_breach).
action_label(omit_total_or_partial_breach, 'Omit total or partial breach').
action_type(orient_professionals_to_comply).
action_label(orient_professionals_to_comply, 'Orient professionals to comply').
action_type(partially_execute_and_receive_object).
action_label(partially_execute_and_receive_object, 'Partially execute and receive object').
action_type(pay_contracted_value).
action_label(pay_contracted_value, 'Pay contracted value').
action_type(pay_taxes).
action_label(pay_taxes, 'Pay taxes').
action_type(present_info_price_reduction).
action_label(present_info_price_reduction, 'Present info for price reduction').
action_type(present_supporting_docs_subcontracting).
action_label(present_supporting_docs_subcontracting, 'Present supporting documents').
action_type(prevent_allocation_of_family_members).
action_label(prevent_allocation_of_family_members, 'Prevent allocate family members').
action_type(prevent_corruption).
action_label(prevent_corruption, 'Prevent corruption').
action_type(prevent_employee_favoritism).
action_label(prevent_employee_favoritism, 'Prevent employee favoritism').
action_type(properly_execute_agreement).
action_label(properly_execute_agreement, 'Properly execute agreement').
action_type(provide_confidentiality_agreement).
action_label(provide_confidentiality_agreement, 'Provide confidentiality agreement').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_documents_to_contracted).
action_label(provide_documents_to_contracted, 'Provide documents to contracted party').
action_type(provide_exclusion_proof).
action_label(provide_exclusion_proof, 'Provide exclusion proof').
action_type(provide_opportunity_of_defense).
action_label(provide_opportunity_of_defense, 'Provide opportunity to defend').
action_type(provide_video_surveillance_services).
action_label(provide_video_surveillance_services, 'Provide video surveillance services').
action_type(provide_written_notification).
action_label(provide_written_notification, 'Provide written notification').
action_type(receive_contractual_guarantee).
action_label(receive_contractual_guarantee, 'Receive contractual guarantee').
action_type(receive_executed_contracted_object).
action_label(receive_executed_contracted_object, 'Receive executed contracted object').
action_type(receive_fiscal_document).
action_label(receive_fiscal_document, 'Receive fiscal document').
action_type(receive_notification_of_breach).
action_label(receive_notification_of_breach, 'Receive notification of breach').
action_type(receive_object).
action_label(receive_object, 'Power to receive object').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payment_for_video_surveillance).
action_label(receive_payment_for_video_surveillance, 'Receive payment for services').
action_type(receive_video_surveillance_services).
action_label(receive_video_surveillance_services, 'Receive video surveillance').
action_type(receive_written_notification).
action_label(receive_written_notification, 'Receive written notification').
action_type(remove_agents_from_contract).
action_label(remove_agents_from_contract, 'Remove agents from contract').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages').
action_type(repair_replace_contract_object).
action_label(repair_replace_contract_object, 'Repair/replace contract object').
action_type(replace_contract_manager).
action_label(replace_contract_manager, 'Replace contract manager').
action_type(request_confidentiality_agreement).
action_label(request_confidentiality_agreement, 'Request confidentiality agreement').
action_type(request_price_adjustment_before_end).
action_label(request_price_adjustment_before_end, 'Request price adjustment before end').
action_type(request_price_readjustment).
action_label(request_price_readjustment, 'Request price readjustment').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(rescind_contract_post_readjustment).
action_label(rescind_contract_post_readjustment, 'Rescind contract post-readjustment').
action_type(respect_bndes_security_policy).
action_label(respect_bndes_security_policy, 'Respect BNDES security policy').
action_type(send_fiscal_document).
action_label(send_fiscal_document, 'Send fiscal document').
action_type(submit_dif).
action_label(submit_dif, 'Submit DIF').
action_type(suspend_execution_of_contract).
action_label(suspend_execution_of_contract, 'Suspend execution').
action_type(suspend_price_review).
action_label(suspend_price_review, 'Suspend price review').
action_type(temporarily_suspend_participation).
action_label(temporarily_suspend_participation, 'Temporarily suspend participation').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').
action_type(terminate_for_insolvency).
action_label(terminate_for_insolvency, 'Terminate for insolvency').
action_type(terminate_for_loss_of_qualification).
action_label(terminate_for_loss_of_qualification, 'Terminate if loses qualification').
action_type(terminate_for_unjustified_delay).
action_label(terminate_for_unjustified_delay, 'Terminate for unjustified delay').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_185_2020).
contract_metadata(contrato_ocs_185_2020, numero_ocs, '185/2020').
contract_metadata(contrato_ocs_185_2020, numero_sap, '4400004340').
contract_metadata(contrato_ocs_185_2020, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_185_2020, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'TECNO-IT TECNOLOGIA, SERVIÇOS E COMUNICAÇÃO LTDA.']).
contract_metadata(contrato_ocs_185_2020, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_185_2020, contratado, 'TECNO-IT TECNOLOGIA, SERVIÇOS E COMUNICAÇÃO LTDA.').
contract_metadata(contrato_ocs_185_2020, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_185_2020, cnpj_contratado, '19.354.200/0001-70').
contract_metadata(contrato_ocs_185_2020, procedimento_licitatorio, 'Pregão Eletrônico nº 22/2020 - BNDES').
contract_metadata(contrato_ocs_185_2020, data_autorizacao, '11/06/2020').
contract_metadata_raw(contrato_ocs_185_2020, 'ip_asn_depad_gpat', '051/2020', 'trecho_literal').
contract_metadata_raw(contrato_ocs_185_2020, 'data_ip_asn_depad_gpat', '28/05/2020', 'trecho_literal').
contract_metadata(contrato_ocs_185_2020, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_185_2020, regulamento, 'Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES').
contract_clause(contrato_ocs_185_2020, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação de serviços de solução de videovigilância, na qual estão incluídos câmeras IP de alta definição, estações de monitoramento, sistemas de gravação e monitoração em tempo real, licenciamento de software, e serviços de instalação, treinamento sob demanda, operação assistida, suporte técnico e manutenção corretiva com reposição de equipamentos e componentes defeituosos para as unidades de escritórios regionais do BNDES no Brasil e do Edifício de Serviços do Rio de Janeiro - RJ, conforme especificações constantes do Termo de Referência (Anexo I do Edital do Pregão Eletrônico nº 22/2020 – BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_185_2020, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 60 (sessenta) meses, a contar da data de 08/09/2020.').
contract_clause(contrato_ocs_185_2020, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_185_2020, clausula_quarta_recebimento_objeto, 'CLÁUSULA QUARTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto por meio do Gestor mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_185_2020, clausula_quinta_preco, 'CLÁUSULA QUINTA– PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 2.190.000,00 (dois milhões, cento e noventa mil reais), conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.   Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.  Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_185_2020, clausula_sexta_pagamento, 'CLÁUSULA SEXTA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, mensalmente, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (como nota fiscal, fatura, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.  Parágrafo Segundo Para toda efetivação de pagamento, o CONTRATADO deverá encaminhar 1 (uma) via do documento fiscal ou equivalente legal à caixa de e-mail nfe@bndes.gov.br, ou, quando emitido em papel, ao Protocolo do Edifício de Serviços do BNDES no Rio de Janeiro - EDSERJ, localizado na Avenida República do Chile nº 100, Térreo, Centro, Rio de Janeiro, CEP nº 20.031-917, no período compreendido entre 10h e 18h.  Parágrafo Terceiro O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. Número da Ordem de Compra/Serviço – OCS; II. Número SAP do Contrato; III. Descrição detalhada do objeto executado e dos respectivos valores; IV. Período de referência da execução do objeto; V. Nome e número do CNPJ do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VI. Nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; VII. Nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; VIII. Tomador dos serviços: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; IX. CNPJ do tomador dos serviços: 33.657.248/0001-89; X. Local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso; e XI. Código dos serviços, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento.  Parágrafo Quarto Ao documento fiscal ou equivalente legal deverão ser anexados: I. Certidões de regularidade fiscal exigidas na fase de habilitação; II. Comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. Em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. Demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado.  Parágrafo Quinto Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.  Parágrafo Sexto Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO.  Parágrafo Sétimo Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.  Parágrafo Oitavo Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.').
contract_clause(contrato_ocs_185_2020, clausula_setima_equilibrio_economico_financeiro_contrato, 'CLÁUSULA SÉTIMA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO', 'O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 31/07/2020, data de apresentação da proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Custo da Tecnologia da Informação (ICTI), divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA, acumulado no respectivo período, sobre o preço referido na Cláusula de Preço deste Instrumento.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. O CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. A comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. Com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.  Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. Caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. Caso a divulgação do índice de reajuste ocorra após o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. O BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. Caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.  Parágrafo Quinto Se o processo de reajuste e/ou revisão de preços não for concluído até o vencimento do Contrato, sua continuidade após o reequilíbrio econômico-financeiro ficará condicionada à manutenção da proposta do CONTRATADO como a condição mais vantajosa para o BNDES, podendo este: I. Realizar negociação de preços junto ao CONTRATADO, de forma a viabilizar a continuidade do ajuste, quando os novos valores fixados após o reajuste e/ou a revisão de preços estiverem acima do patamar apurado no mercado; ou  II. Rescindir o Contrato, mediante aviso prévio ao CONTRATADO, com antecedência de 30 (trinta) dias, quando resultar infrutífera a negociação indicada no inciso anterior.  Parágrafo Sexto Na ocorrência da hipótese prevista no inciso II do Parágrafo anterior, o CONTRATADO fará jus à integralidade dos valores apurados no processo de reajuste e/ou revisão de preços até o término do Contrato, não podendo, todavia, reclamar qualquer indenização em razão da rescisão do mesmo.').
contract_clause(contrato_ocs_185_2020, clausula_oitava_matriz_riscos, 'CLÁUSULA OITAVA – MATRIZ DE RISCOS O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.', 'CLÁUSULA OITAVA – MATRIZ DE RISCOS O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.').
contract_clause(contrato_ocs_185_2020, clausula_nona_garantia_contratual, 'CLÁUSULA NONA – GARANTIA CONTRATUAL O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 109.500,00 (cento e nove mil e quinhentos reais), correspondente a 5% (cinco por cento) do valor do presente Contrato, que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) Responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) Vigência pelo prazo contratual; a.3) Prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) Renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) Vigência pelo prazo contratual; a.3) Prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Em caso de alteração do valor contratual, utilização total ou parcial da garantia pelo BNDES, ou em situações outras que impliquem em perda ou insuficiência da garantia, o CONTRATADO deverá providenciar a complementação ou substituição da garantia prestada no prazo determinado pelo BNDES ou pactuado em aditivo ou em apostilamento, observadas as condições originais para aceitação da garantia estipuladas nesta Cláusula.  Parágrafo Terceiro Nos demais casos de alteração do Contrato, sempre que o mesmo for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.', 'CLÁUSULA NONA – GARANTIA CONTRATUAL O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 109.500,00 (cento e nove mil e quinhentos reais), correspondente a 5% (cinco por cento) do valor do presente Contrato, que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) Responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) Vigência pelo prazo contratual; a.3) Prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) Renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) Vigência pelo prazo contratual; a.3) Prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Em caso de alteração do valor contratual, utilização total ou parcial da garantia pelo BNDES, ou em situações outras que impliquem em perda ou insuficiência da garantia, o CONTRATADO deverá providenciar a complementação ou substituição da garantia prestada no prazo determinado pelo BNDES ou pactuado em aditivo ou em apostilamento, observadas as condições originais para aceitação da garantia estipuladas nesta Cláusula.  Parágrafo Terceiro Nos demais casos de alteração do Contrato, sempre que o mesmo for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.').
contract_clause(contrato_ocs_185_2020, clausula_decima_obrigações_contratado, 'CLÁUSULA DÉCIMA – OBRIGAÇÕES DO CONTRATADO Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. Manter durante a vigência deste Contrato todas as condições de habilitação exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. Comunicar a imposição, de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. Reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. Reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. Pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. Providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) Extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) Enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VII. Permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; VIII. Obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; IX. Designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; X. Apresentar, em até 10 dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) As informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; b) Em caso de subcontratação, o CONTRATADO deverá apresentar, ainda, uma DIF para cada subcontratado, devidamente preenchida(s) com os respectivos dados e assinada(s) pelo(s) respectivo(s) representante(s) legal(is). XI. Responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES.', 'CLÁUSULA DÉCIMA – OBRIGAÇÕES DO CONTRATADO Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. Manter durante a vigência deste Contrato todas as condições de habilitação exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. Comunicar a imposição, de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. Reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. Reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. Pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. Providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) Extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) Enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VII. Permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; VIII. Obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; IX. Designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; X. Apresentar, em até 10 dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) As informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; b) Em caso de subcontratação, o CONTRATADO deverá apresentar, ainda, uma DIF para cada subcontratado, devidamente preenchida(s) com os respectivos dados e assinada(s) pelo(s) respectivo(s) representante(s) legal(is). XI. Responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES.').
contract_clause(contrato_ocs_185_2020, clausula_decima_primeira_conduta_etica_contratado_bndes, 'CLÁUSULA DÉCIMA PRIMEIRA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. Não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. Impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. Providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. Observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação, bem como a Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. Adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.   Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão por meio dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).', 'CLÁUSULA DÉCIMA PRIMEIRA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. Não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. Impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. Providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. Observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação, bem como a Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. Adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.   Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão por meio dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_185_2020, clausula_decima_segunda_sigilo_informacoes, 'CLÁUSULA DÉCIMA SEGUNDA – SIGILO DAS INFORMAÇÕES Caso o CONTRATADO venha a ter acesso a dados, materiais, documentos e informações de natureza sigilosa, direta ou indiretamente, em decorrência da execução do objeto contratual, deverá manter o sigilo dos mesmos, bem como orientar os profissionais envolvidos a cumprir esta obrigação, respeitando-se as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES.  Parágrafo Único Assim que solicitado pelo Gestor do Contrato, o CONTRATADO deverá providenciar a assinatura, por seu representante legal e pelos profissionais que tiverem acesso a informações sigilosas, dos Termos de Confidencialidade a serem disponibilizados pelo BNDES.', 'CLÁUSULA DÉCIMA SEGUNDA – SIGILO DAS INFORMAÇÕES Caso o CONTRATADO venha a ter acesso a dados, materiais, documentos e informações de natureza sigilosa, direta ou indiretamente, em decorrência da execução do objeto contratual, deverá manter o sigilo dos mesmos, bem como orientar os profissionais envolvidos a cumprir esta obrigação, respeitando-se as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES.  Parágrafo Único Assim que solicitado pelo Gestor do Contrato, o CONTRATADO deverá providenciar a assinatura, por seu representante legal e pelos profissionais que tiverem acesso a informações sigilosas, dos Termos de Confidencialidade a serem disponibilizados pelo BNDES.').
contract_clause(contrato_ocs_185_2020, clausula_decima_terceira_obrigações_bndes, 'CLÁUSULA DÉCIMA TERCEIRA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. Realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. Designar, como Gestor do Contrato, o Sr. José Maciel Franco Junior, que atualmente exerce a função de Coordenador de Serviços da ATI/DESET/GINF, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. Substituir, quando conveniente, o Gestor do Contrato, por outro profissional, mediante comunicação escrita ao CONTRATADO; IV. Fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; V. Colocar à disposição do CONTRATADO todas as informações necessárias à perfeita execução dos serviços objeto deste Contrato; e VI. Comunicar ao CONTRATADO, por escrito: a) Quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) A abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) A aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_185_2020, clausula_decima_quarta_cessão_contrato_credito_sucessão_subcontratação, 'CLÁUSULA DÉCIMA QUARTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. Aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. Manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É admitida a subcontratação de parcela do objeto deste Contrato, nos limites previstos no item 27 do Termo de Referência (Anexo I deste Contrato), condicionada aos seguintes requisitos: I. Aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal operação; e II. Atendimento de todas as condições contratuais e requisitos para a subcontratação previstos no Edital e no Termo de Referência (Anexo I deste Contrato), cabendo ao CONTRATADO apresentar, sempre que solicitado pelo BNDES, os respectivos documentos comprobatórios.  Parágrafo Quarto A subcontratação pode ser realizada com sociedades distintas e de forma simultânea, devendo, em todos os casos, ser relacionada à parcela do objeto autorizada pelo BNDES.  Parágrafo Quinto Caso o CONTRATADO opte por subcontratar o objeto deste Contrato, permanecerá como responsável perante o BNDES pela adequada execução do ajuste, sujeitando-se, inclusive, às penalidades previstas neste Contrato, na hipótese de não cumprir as obrigações ora pactuadas, ainda que por culpa da sociedade subcontratada.').
contract_clause(contrato_ocs_185_2020, clausula_decima_quinta_penalidades, 'CLÁUSULA DÉCIMA QUINTA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. Advertência; II. Multa de até 20% (vinte por cento) sobre a parcela contratual descumprida, a critério da autoridade competente do BNDES, caso o descumprimento dos prazos de nível de serviço estabelecidos enseje ajustes de pagamento superiores aos limites previstos para descontos; III. Multa de até 10% (dez por cento) sobre o valor global do Contrato, a critério da autoridade competente do BNDES, em razão de qualquer descumprimento das demais obrigações contratuais, não previstas nos itens acima; e IV. Suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades indicadas nesta Cláusula somente poderão ser aplicadas após procedimento administrativo, e desde que assegurados o contraditório e a ampla defesa, facultada ao CONTRATADO a defesa prévia, no prazo de 10 (dez) dias úteis.  Parágrafo Segundo Contra a decisão de aplicação de penalidade, o CONTRATADO poderá interpor o recurso cabível, na forma e no prazo previstos no Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES.  Parágrafo Terceiro A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.  Parágrafo Quarto A multa prevista nesta Cláusula poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto No caso de uso indevido de informações sigilosas, observar-se-ão, no que couber, os termos da Lei nº 12.527/2011 e do Decreto nº 7.724/2012.  Parágrafo Sétimo No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. Tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. Tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. Demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_185_2020, clausula_decima_sexta_alterações_contratuais, 'CLÁUSULA DÉCIMA SEXTA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que: I. As alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. É vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.  Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_185_2020, clausula_decima_setima_extinção_contrato, 'CLÁUSULA DÉCIMA SÉTIMA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se, ainda, que é cabível a sua resolução: I. Em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. Na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. Em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo; IV. Quando for decretada a falência do CONTRATADO; V. Caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VI. Na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. Caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal; VIII. Em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; IX. Na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; X. Em razão da dissolução do CONTRATADO; XI. Quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato; e XII. Em decorrência de atraso, lentidão ou paralisação injustificáveis da execução do objeto do Contrato, que caracterize a impossibilidade de sua conclusão no prazo pactuado.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_185_2020, clausula_decima_oitava_disposições_finais, 'CLÁUSULA DÉCIMA OITAVA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.  Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência do Pregão Eletrônico nº 22/2020 - BNDES Anexo II - Proposta Anexo III - Matriz de Risco Anexo IV - Termo de Confidencialidade do Representante da CONTRATADO Anexo V - Termo de Confidencialidade dos Profissionais Anexo VI - Termo de Confidencialidade do Representante do Subcontratado  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_185_2020, clausula_decima_nona_foro, 'CLÁUSULA DÉCIMA NONA – FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  As folhas deste Contrato foram conferidas pela advogada do BNDES, Alice Braga Boynard, por autorização do(s) representante(s) legal(is) que o assina(m).  As partes consideram, para todos os efeitos, a data mencionada abaixo como a da formalização jurídica deste instrumento.   Rio de Janeiro, 31 de agosto de 2020.').

% ===== END =====
