% ===== KOA Combined Output | contract_id: contrato_ocs_344_2022 =====

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
% UFO-only grounding generated from: KOA_Contrato_OCS_344_2022_-_DADB_(fones).pl
% contract_id: contrato_ocs_344_2022

instance_of(contrato_ocs_344_2022, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(dadb_equipamentos_e_servicos_de_informatica_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_344_2022).
plays_role(dadb_equipamentos_e_servicos_de_informatica_ltda, hired_service_provider_role, contrato_ocs_344_2022).

clause_of(clausula_primeira_objeto, contrato_ocs_344_2022).
clause_of(clausula_segunda_vigencia, contrato_ocs_344_2022).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_344_2022).
clause_of(clausula_quarta_ajustes_pagamentos, contrato_ocs_344_2022).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_344_2022).
clause_of(clausula_sexta_garantia_bens_fornecidos, contrato_ocs_344_2022).
clause_of(clausula_setima_preco, contrato_ocs_344_2022).
clause_of(clausula_oitava_pagamento, contrato_ocs_344_2022).
clause_of(clausula_nona_equilibrio_economico_financeiro_do_contrato, contrato_ocs_344_2022).
clause_of(clausula_decima_matriz_de_riscos, contrato_ocs_344_2022).
clause_of(clausula_decima_primeira_obrigações_do_contratado, contrato_ocs_344_2022).
clause_of(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, contrato_ocs_344_2022).
clause_of(clausula_decima_terceira_sigilo_das_informações, contrato_ocs_344_2022).
clause_of(clausula_decima_quarta_acesso_protecao_dados_pessoais, contrato_ocs_344_2022).
clause_of(clausula_decima_quinta_obrigacoes_bndes, contrato_ocs_344_2022).
clause_of(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, contrato_ocs_344_2022).
clause_of(clausula_decima_setima_cessao_contrato_credito_sucessao_contratual_subcontratacao, contrato_ocs_344_2022).
clause_of(clausula_decima_oitava_penalidades, contrato_ocs_344_2022).
clause_of(clausula_decima_nona_alterações_contratuais, contrato_ocs_344_2022).
clause_of(clausula_vigésima_extinção_do_contrato, contrato_ocs_344_2022).
clause_of(clausula_vigésima_primeira_disposições_finais, contrato_ocs_344_2022).
clause_of(clausula_vigésima_segunda_foro, contrato_ocs_344_2022).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, provide_headsets).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_headsets).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_to_have_contract_in_effect).
legal_relation_instance(clausula_segunda_vigencia, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, power_to_enforce_contract).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, execute_object_according_to_specifications).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_execution_according_to_specifications).
legal_relation_instance(clausula_quarta_ajustes_pagamentos, duty_to_omit, dadb_equipamentos_e_servicos_de_informatica_ltda, omit_delaying_delivery).
legal_relation_instance(clausula_quarta_ajustes_pagamentos, subjection, dadb_equipamentos_e_servicos_de_informatica_ltda, subjected_to_price_reduction).
legal_relation_instance(clausula_quarta_ajustes_pagamentos, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction_indices).
legal_relation_instance(clausula_quarta_ajustes_pagamentos, duty_to_omit, dadb_equipamentos_e_servicos_de_informatica_ltda, omit_actions_triggering_penalties).
legal_relation_instance(clausula_quarta_ajustes_pagamentos, subjection, dadb_equipamentos_e_servicos_de_informatica_ltda, subjected_to_penalties).
legal_relation_instance(clausula_quarta_ajustes_pagamentos, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_sexta_garantia_bens_fornecidos, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, solve_defects).
legal_relation_instance(clausula_sexta_garantia_bens_fornecidos, power, dadb_equipamentos_e_servicos_de_informatica_ltda, replace_defective_goods).
legal_relation_instance(clausula_sexta_garantia_bens_fornecidos, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_goods_within_warranty).
legal_relation_instance(clausula_sexta_garantia_bens_fornecidos, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, transport_goods_for_warranty).
legal_relation_instance(clausula_sexta_garantia_bens_fornecidos, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, provide_technician_support).
legal_relation_instance(clausula_setima_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_party).
legal_relation_instance(clausula_setima_preco, no_right_to_action, dadb_equipamentos_e_servicos_de_informatica_ltda, demand_indemnification).
legal_relation_instance(clausula_setima_preco, right_to_action, dadb_equipamentos_e_servicos_de_informatica_ltda, receive_payment).
legal_relation_instance(clausula_setima_preco, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, bear_quantities_error_onus).
legal_relation_instance(clausula_setima_preco, subjection, dadb_equipamentos_e_servicos_de_informatica_ltda, accept_proportional_reduction).
legal_relation_instance(clausula_oitava_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payment).
legal_relation_instance(clausula_oitava_pagamento, right_to_action, dadb_equipamentos_e_servicos_de_informatica_ltda, receive_payment).
legal_relation_instance(clausula_oitava_pagamento, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, present_fiscal_document).
legal_relation_instance(clausula_oitava_pagamento, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, ensure_fiscal_document_conformity).
legal_relation_instance(clausula_oitava_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_overpayments).
legal_relation_instance(clausula_oitava_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, reject_fiscal_document).
legal_relation_instance(clausula_oitava_pagamento, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, provide_digital_fiscal_document).
legal_relation_instance(clausula_oitava_pagamento, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_penalties).
legal_relation_instance(clausula_nona_equilibrio_economico_financeiro_do_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_price_revision).
legal_relation_instance(clausula_nona_equilibrio_economico_financeiro_do_contrato, right_to_action, dadb_equipamentos_e_servicos_de_informatica_ltda, request_price_revision).
legal_relation_instance(clausula_nona_equilibrio_economico_financeiro_do_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_price_revision_request).
legal_relation_instance(clausula_nona_equilibrio_economico_financeiro_do_contrato, no_right_to_action, dadb_equipamentos_e_servicos_de_informatica_ltda, request_price_revision_after_deadline).
legal_relation_instance(clausula_nona_equilibrio_economico_financeiro_do_contrato, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, request_price_revision).
legal_relation_instance(clausula_decima_matriz_de_riscos, no_right_to_action, dadb_equipamentos_e_servicos_de_informatica_ltda, celebrate_additives_for_allocated_risks).
legal_relation_instance(clausula_decima_matriz_de_riscos, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, manage_and_absorb_risks).
legal_relation_instance(clausula_decima_matriz_de_riscos, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, manage_and_absorb_risks).
legal_relation_instance(clausula_decima_primeira_obrigações_do_contratado, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, maintain_qualification_conditions).
legal_relation_instance(clausula_decima_primeira_obrigações_do_contratado, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, communicate_penalty_impediment).
legal_relation_instance(clausula_decima_primeira_obrigações_do_contratado, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, repair_correct_remove_reconstruct_substitute).
legal_relation_instance(clausula_decima_primeira_obrigações_do_contratado, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, repair_damages_and_losses).
legal_relation_instance(clausula_decima_primeira_obrigações_do_contratado, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, pay_all_charges_and_taxes).
legal_relation_instance(clausula_decima_primeira_obrigações_do_contratado, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, assume_full_responsibility).
legal_relation_instance(clausula_decima_primeira_obrigações_do_contratado, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, exclude_from_simples_nacional).
legal_relation_instance(clausula_decima_primeira_obrigações_do_contratado, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, allow_inspections).
legal_relation_instance(clausula_decima_primeira_obrigações_do_contratado, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, obey_instructions).
legal_relation_instance(clausula_decima_primeira_obrigações_do_contratado, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, designate_representative).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, maintain_integrity).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, maintain_integrity).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_omit, dadb_equipamentos_e_servicos_de_informatica_ltda, omit_offering_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_omit, dadb_equipamentos_e_servicos_de_informatica_ltda, omit_employee_favoritism).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_omit, dadb_equipamentos_e_servicos_de_informatica_ltda, omit_family_allocation).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, observe_ethics_policy).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, adopt_sustainability_practices).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, remove_agents).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, report_agents_removed).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_irregularity_reports).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informações, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, maintain_confidentiality).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informações, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, orient_professionals_to_maintain_confidentiality).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informações, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, provide_confidentiality_terms_signature).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informações, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_confidentiality_terms_signature).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, obtain_consent_data_owners).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, follow_bndes_instructions_data_treatment).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_of_regress).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, provide_data_access_channel).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, inform_bndes_of_data_requests).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, maintain_data_processing_registry).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, inform_bndes_data_breach).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, delete_personal_data_end_contract).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, process_public_data).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contracted_party).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, right_to_action, dadb_equipamentos_e_servicos_de_informatica_ltda, receive_payments_from_bndes).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_substitute_contract_manager).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract_manager).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_receiving_committee).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_necessary_information).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_irregularities_investigation).
legal_relation_instance(clausula_decima_quinta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalties).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, comprovar_inexistencia_decisao_administrativa).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspender_execucao_contratual).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, solicitar_comprovacao_inexistencia_decisao).
legal_relation_instance(clausula_decima_sexta_equidade_genero_valorizacao_diversidade, disability, dadb_equipamentos_e_servicos_de_informatica_ltda, evitar_discriminacao_raca_genero).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_contratual_subcontratacao, duty_to_omit, dadb_equipamentos_e_servicos_de_informatica_ltda, not_cede_contract).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_contratual_subcontratacao, no_right_to_action, dadb_equipamentos_e_servicos_de_informatica_ltda, not_cede_contract).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_contratual_subcontratacao, duty_to_omit, dadb_equipamentos_e_servicos_de_informatica_ltda, not_cede_credit).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_contratual_subcontratacao, no_right_to_action, dadb_equipamentos_e_servicos_de_informatica_ltda, not_cede_credit).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_contratual_subcontratacao, duty_to_omit, dadb_equipamentos_e_servicos_de_informatica_ltda, not_issue_credit_title).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_contratual_subcontratacao, no_right_to_action, dadb_equipamentos_e_servicos_de_informatica_ltda, not_issue_credit_title).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_contratual_subcontratacao, duty_to_omit, dadb_equipamentos_e_servicos_de_informatica_ltda, not_subcontract).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_contratual_subcontratacao, no_right_to_action, dadb_equipamentos_e_servicos_de_informatica_ltda, not_subcontract).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_contratual_subcontratacao, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, maintain_contract_conditions).
legal_relation_instance(clausula_decima_setima_cessao_contrato_credito_sucessao_contratual_subcontratacao, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_risks).
legal_relation_instance(clausula_decima_oitava_penalidades, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, comply_with_bndes_requirements).
legal_relation_instance(clausula_decima_oitava_penalidades, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, comply_with_legal_obligations).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, dadb_equipamentos_e_servicos_de_informatica_ltda, receive_warning).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, dadb_equipamentos_e_servicos_de_informatica_ltda, receive_fine).
legal_relation_instance(clausula_decima_oitava_penalidades, subjection, dadb_equipamentos_e_servicos_de_informatica_ltda, receive_suspension).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_oitava_penalidades, right_to_action, dadb_equipamentos_e_servicos_de_informatica_ltda, request_reconsideration_or_appeal).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_oitava_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_credit_or_collect_judicially).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_modify_contract_denature).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_contract).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, respond_damages_unjustified_refusal).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_alteration).
legal_relation_instance(clausula_decima_nona_alterações_contratuais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_refusal_alteration).
legal_relation_instance(clausula_vigésima_extinção_do_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_other_party_of_termination).
legal_relation_instance(clausula_vigésima_extinção_do_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_vigésima_extinção_do_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, defend_against_termination).
legal_relation_instance(clausula_vigésima_extinção_do_contrato, subjection, dadb_equipamentos_e_servicos_de_informatica_ltda, be_subject_to_termination).
legal_relation_instance(clausula_vigésima_extinção_do_contrato, duty_to_act, dadb_equipamentos_e_servicos_de_informatica_ltda, continue_performance_until_termination).
legal_relation_instance(clausula_vigésima_primeira_disposições_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights_at_any_time).
legal_relation_instance(clausula_vigésima_primeira_disposições_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_strict_compliance_after_omission).
legal_relation_instance(clausula_vigésima_segunda_foro, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, accept_rio_de_janeiro_court).
legal_relation_instance(clausula_vigésima_segunda_foro, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, sue_in_rio_de_janeiro_court).
legal_relation_instance(clausula_vigésima_segunda_foro, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, sue_elsewhere).
legal_relation_instance(clausula_vigésima_segunda_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, sue_elsewhere).

% --- Action catalog (local to this contract grounding) ---
action_type(accept_proportional_reduction).
action_label(accept_proportional_reduction, 'Accept proportional reduction').
action_type(accept_rio_de_janeiro_court).
action_label(accept_rio_de_janeiro_court, 'Accept Rio court').
action_type(adopt_sustainability_practices).
action_label(adopt_sustainability_practices, 'Adopt sustainability practices').
action_type(allow_central_bank_access).
action_label(allow_central_bank_access, 'Allow Central Bank access').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(alter_contract).
action_label(alter_contract, 'Alter contract').
action_type(alter_contract_manager).
action_label(alter_contract_manager, 'Change contract manager').
action_type(analyze_price_revision_request).
action_label(analyze_price_revision_request, 'Analyze price revision request').
action_type(analyze_risks).
action_label(analyze_risks, 'Analyze risks').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(apply_price_reduction_indices).
action_label(apply_price_reduction_indices, 'Apply price reduction indices').
action_type(assume_full_responsibility).
action_label(assume_full_responsibility, 'Assume full responsibility').
action_type(be_subject_to_termination).
action_label(be_subject_to_termination, 'Subject to termination').
action_type(bear_quantities_error_onus).
action_label(bear_quantities_error_onus, 'Bear quantities error onus').
action_type(celebrate_additives_for_allocated_risks).
action_label(celebrate_additives_for_allocated_risks, 'Celebrate additives for allocated risks').
action_type(communicate_instructions).
action_label(communicate_instructions, 'Communicate instructions').
action_type(communicate_irregularities_investigation).
action_label(communicate_irregularities_investigation, 'Communicate investigation').
action_type(communicate_penalties).
action_label(communicate_penalties, 'Communicate penalties').
action_type(communicate_penalty_impediment).
action_label(communicate_penalty_impediment, 'Communicate penalty impediment').
action_type(comply_with_bndes_requirements).
action_label(comply_with_bndes_requirements, 'Comply with BNDES requirements').
action_type(comply_with_legal_obligations).
action_label(comply_with_legal_obligations, 'Comply with legal obligations').
action_type(comprovar_inexistencia_decisao_administrativa).
action_label(comprovar_inexistencia_decisao_administrativa, 'Prove no sanction').
action_type(continue_performance_until_termination).
action_label(continue_performance_until_termination, 'Continue performance').
action_type(deduct_credit_or_collect_judicially).
action_label(deduct_credit_or_collect_judicially, 'Deduct/collect credits').
action_type(deduct_overpayments).
action_label(deduct_overpayments, 'Deduct overpayments').
action_type(deduct_penalties).
action_label(deduct_penalties, 'Deduct penalties').
action_type(defend_against_termination).
action_label(defend_against_termination, 'Right to defend against termination').
action_type(delete_personal_data_end_contract).
action_label(delete_personal_data_end_contract, 'Delete personal data at contract end').
action_type(demand_execution_according_to_specifications).
action_label(demand_execution_according_to_specifications, 'Demand proper execution').
action_type(demand_indemnification).
action_label(demand_indemnification, 'Demand indemnification').
action_type(demand_strict_compliance_after_omission).
action_label(demand_strict_compliance_after_omission, 'Demand strict compliance after omission').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_receiving_committee).
action_label(designate_receiving_committee, 'Designate receiving committee').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(designate_substitute_contract_manager).
action_label(designate_substitute_contract_manager, 'Designate substitute manager').
action_type(effect_object_receipt).
action_label(effect_object_receipt, 'Effect object receipt').
action_type(ensure_fiscal_document_conformity).
action_label(ensure_fiscal_document_conformity, 'Ensure fiscal document conformity').
action_type(evitar_discriminacao_raca_genero).
action_label(evitar_discriminacao_raca_genero, 'Avoid race/gender discrimination').
action_type(exclude_from_simples_nacional).
action_label(exclude_from_simples_nacional, 'Exclude from Simples Nacional').
action_type(execute_object_according_to_specifications).
action_label(execute_object_according_to_specifications, 'Execute according to specifications').
action_type(exercise_rights_at_any_time).
action_label(exercise_rights_at_any_time, 'Exercise rights at any time').
action_type(follow_bndes_instructions_data_treatment).
action_label(follow_bndes_instructions_data_treatment, 'Follow BNDES data treatment instructions').
action_type(formalize_alteration).
action_label(formalize_alteration, 'Formalize contract alteration').
action_type(guarantee_no_infringement).
action_label(guarantee_no_infringement, 'Guarantee no infringement').
action_type(inform_bndes_data_breach).
action_label(inform_bndes_data_breach, 'Inform BNDES data breach').
action_type(inform_bndes_of_data_requests).
action_label(inform_bndes_of_data_requests, 'Inform BNDES of data requests').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality').
action_type(maintain_contract_conditions).
action_label(maintain_contract_conditions, 'Maintain contract conditions').
action_type(maintain_data_processing_registry).
action_label(maintain_data_processing_registry, 'Maintain data processing registry').
action_type(maintain_integrity).
action_label(maintain_integrity, 'Maintain integrity').
action_type(maintain_qualification_conditions).
action_label(maintain_qualification_conditions, 'Maintain qualification conditions').
action_type(make_payment).
action_label(make_payment, 'Make payment').
action_type(make_payments_to_contracted_party).
action_label(make_payments_to_contracted_party, 'Make payments').
action_type(manage_and_absorb_risks).
action_label(manage_and_absorb_risks, 'Manage and absorb risks').
action_type(merge_split_incorporate).
action_label(merge_split_incorporate, 'Merge/Split/Incorporate').
action_type(not_cede_contract).
action_label(not_cede_contract, 'Not cede contract').
action_type(not_cede_credit).
action_label(not_cede_credit, 'Not cede credit').
action_type(not_issue_credit_title).
action_label(not_issue_credit_title, 'Not issue credit title').
action_type(not_subcontract).
action_label(not_subcontract, 'Not subcontract').
action_type(notify_contracted_party_manager_change).
action_label(notify_contracted_party_manager_change, 'Notify manager change').
action_type(notify_other_party_of_termination).
action_label(notify_other_party_of_termination, 'Notify other party').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_ethics_policy).
action_label(observe_ethics_policy, 'Observe ethics policy').
action_type(obtain_consent_data_owners).
action_label(obtain_consent_data_owners, 'Obtain data owner consent').
action_type(omit_actions_triggering_penalties).
action_label(omit_actions_triggering_penalties, 'Omit actions triggering penalties').
action_type(omit_delaying_delivery).
action_label(omit_delaying_delivery, 'Omit delaying delivery').
action_type(omit_employee_favoritism).
action_label(omit_employee_favoritism, 'Omit employee favoritism').
action_type(omit_family_allocation).
action_label(omit_family_allocation, 'Omit family allocation').
action_type(omit_modify_contract_denature).
action_label(omit_modify_contract_denature, 'Don\'t modify contract to denature').
action_type(omit_offering_advantage).
action_label(omit_offering_advantage, 'Omit offering undue advantage').
action_type(omit_refusal_alteration).
action_label(omit_refusal_alteration, 'Don\'t refuse contract alteration').
action_type(orient_professionals_to_maintain_confidentiality).
action_label(orient_professionals_to_maintain_confidentiality, 'Orient professionals about confidentiality').
action_type(pay_all_charges_and_taxes).
action_label(pay_all_charges_and_taxes, 'Pay taxes').
action_type(pay_contracted_party).
action_label(pay_contracted_party, 'Pay the contracted party').
action_type(power_to_enforce_contract).
action_label(power_to_enforce_contract, 'Power to enforce contract').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(process_public_data).
action_label(process_public_data, 'Process public data').
action_type(provide_confidentiality_terms_signature).
action_label(provide_confidentiality_terms_signature, 'Provide confidentiality terms signature').
action_type(provide_data_access_channel).
action_label(provide_data_access_channel, 'Provide data access channel').
action_type(provide_digital_fiscal_document).
action_label(provide_digital_fiscal_document, 'Provide digital fiscal document').
action_type(provide_ethics_and_security_info).
action_label(provide_ethics_and_security_info, 'Provide ethics and security info').
action_type(provide_headsets).
action_label(provide_headsets, 'Provide headsets').
action_type(provide_necessary_information).
action_label(provide_necessary_information, 'Provide necessary information').
action_type(provide_technician_support).
action_label(provide_technician_support, 'Provide technician support').
action_type(receive_fine).
action_label(receive_fine, 'Subject to fine').
action_type(receive_goods_within_warranty).
action_label(receive_goods_within_warranty, 'Receive goods within warranty').
action_type(receive_headsets).
action_label(receive_headsets, 'Receive headsets').
action_type(receive_irregularities_investigation).
action_label(receive_irregularities_investigation, 'Receive investigation notice').
action_type(receive_irregularity_reports).
action_label(receive_irregularity_reports, 'Receive irregularity reports').
action_type(receive_necessary_information).
action_label(receive_necessary_information, 'Receive necessary information').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payments_from_bndes).
action_label(receive_payments_from_bndes, 'Receive payments').
action_type(receive_penalties).
action_label(receive_penalties, 'Receive penalty notice').
action_type(receive_suspension).
action_label(receive_suspension, 'Subject to suspension').
action_type(receive_warning).
action_label(receive_warning, 'Subject to warning').
action_type(reject_fiscal_document).
action_label(reject_fiscal_document, 'Reject fiscal document').
action_type(remove_agents).
action_label(remove_agents, 'Remove agents').
action_type(repair_correct_remove_reconstruct_substitute).
action_label(repair_correct_remove_reconstruct_substitute, 'Repair or replace defective object').
action_type(repair_damages_and_losses).
action_label(repair_damages_and_losses, 'Repair damages').
action_type(replace_defective_goods).
action_label(replace_defective_goods, 'Replace defective goods').
action_type(report_agents_removed).
action_label(report_agents_removed, 'Report agents removed').
action_type(request_confidentiality_terms_signature).
action_label(request_confidentiality_terms_signature, 'Request confidentiality terms signature').
action_type(request_ethics_and_security_info).
action_label(request_ethics_and_security_info, 'Request ethics and security info').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_price_revision_after_deadline).
action_label(request_price_revision_after_deadline, 'Request price revision after deadline').
action_type(request_proof_of_regularity).
action_label(request_proof_of_regularity, 'Request proof of regularity').
action_type(request_reconsideration_or_appeal).
action_label(request_reconsideration_or_appeal, 'Request reconsideration/appeal').
action_type(respond_damages_unjustified_refusal).
action_label(respond_damages_unjustified_refusal, 'Liable for damages from unjustified refusal').
action_type(right_of_regress).
action_label(right_of_regress, 'Right of regress').
action_type(right_to_have_contract_in_effect).
action_label(right_to_have_contract_in_effect, 'Right to have contract in effect').
action_type(solicitar_comprovacao_inexistencia_decisao).
action_label(solicitar_comprovacao_inexistencia_decisao, 'Request proof of no sanction').
action_type(solve_defects).
action_label(solve_defects, 'Solve defects in goods').
action_type(subjected_to_penalties).
action_label(subjected_to_penalties, 'Subjected to penalties').
action_type(subjected_to_price_reduction).
action_label(subjected_to_price_reduction, 'Subjected to price reduction').
action_type(sue_elsewhere).
action_label(sue_elsewhere, 'Omit suing elsewhere').
action_type(sue_in_rio_de_janeiro_court).
action_label(sue_in_rio_de_janeiro_court, 'Sue in Rio court').
action_type(supply_new_goods).
action_label(supply_new_goods, 'Supply new goods').
action_type(suspender_execucao_contratual).
action_label(suspender_execucao_contratual, 'Suspend contract execution').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').
action_type(transport_goods_for_warranty).
action_label(transport_goods_for_warranty, 'Transport goods for warranty').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_344_2022).
contract_metadata(contrato_ocs_344_2022, numero_ocs, '344/2022').
contract_metadata(contrato_ocs_344_2022, numero_sap, '4400005311').
contract_metadata(contrato_ocs_344_2022, tipo_contrato, 'CONTRATO DE FORNECIMENTO DE BENS').
contract_metadata(contrato_ocs_344_2022, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'DADB EQUIPAMENTOS E SERVIÇOS DE INFORMÁTICA LTDA']).
contract_metadata(contrato_ocs_344_2022, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_344_2022, contratado, 'DADB EQUIPAMENTOS E SERVIÇOS DE INFORMÁTICA LTDA').
contract_metadata(contrato_ocs_344_2022, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_344_2022, cnpj_contratado, '12.980.808/0001-61').
contract_metadata(contrato_ocs_344_2022, procedimento_licitatorio, 'Pregão Eletrônico nº 39/2022 - BNDES').
contract_metadata(contrato_ocs_344_2022, data_autorizacao, '04/11/2022').
contract_metadata_raw(contrato_ocs_344_2022, 'ip_ati_deset', '31/2022', 'trecho_literal').
contract_metadata_raw(contrato_ocs_344_2022, 'data_ip_ati_deset', '25/10/2022', 'trecho_literal').
contract_metadata_raw(contrato_ocs_344_2022, 'rubricas', ['1750100021', '31016000111'], 'trecho_literal').
contract_metadata(contrato_ocs_344_2022, centro_custo, 'BN30005000').
contract_metadata(contrato_ocs_344_2022, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_344_2022, regulamento, 'Regulamento Licitações e Contratos do Sistema BNDES').
contract_clause(contrato_ocs_344_2022, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto o fornecimento de fones de ouvido com microfones (headsets), conforme especificações constantes do Termo de Referência (Anexo I do Edital do Pregão Eletrônico nº 39/2022 - BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_344_2022, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 6 (seis) meses, a contar da data de sua assinatura.').
contract_clause(contrato_ocs_344_2022, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_344_2022, clausula_quarta_ajustes_pagamentos, 'CLÁUSULA QUARTA – AJUSTES DE PAGAMENTOS', 'O atraso na entrega dos equipamentos acarretará a aplicação dos índices de redução do preço, previstos no Anexo I (Termo de Referência) deste Contrato, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_344_2022, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através da Comissão de Recebimento, mencionada na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_344_2022, clausula_sexta_garantia_bens_fornecidos, 'CLÁUSULA SEXTA – GARANTIA DOS BENS FORNECIDOS', 'A garantia será de 90 (noventa) dias, contados do recebimento definitivo dos bens em questão, salvo se a proposta (Anexo II deste Contrato) previr prazo maior, observado o disposto no Anexo I (Termo de Referência) deste Contrato.  Parágrafo Primeiro A garantia ocorrerá sem nenhum ônus para o BNDES e será prestada sob responsabilidade do CONTRATADO, inclusive quando for necessário o transporte dos bens ou ainda o traslado e a hospedagem de técnicos do CONTRATADO ou qualquer outro tipo de serviço necessário para o cumprimento da garantia. Parágrafo Segundo O CONTRATADO deverá solucionar todos os vícios e defeitos apresentados pelos bens, dentro do período de garantia, no prazo de 20 dias corridos após a abertura do chamado, podendo substitui-los por outros bens, novos e perfeitos, que atendam às mesmas especificações estipuladas neste Contrato e em seus Anexos, no mesmo prazo para o conserto.').
contract_clause(contrato_ocs_344_2022, clausula_setima_preco, 'CLÁUSULA SÉTIMA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 12.100,00 (doze mil e cem reais), conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento:  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.   Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo, conforme o caso: I. complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato; ou II. reverter o excedente como lucro, sendo facultada ao BNDES a promoção de negociação com vistas a eventual prorrogação contratual.').
contract_clause(contrato_ocs_344_2022, clausula_oitava_pagamento, 'CLÁUSULA OITAVA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, em parcela única, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente  nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte do fornecimento do bem.  Parágrafo Segundo A apresentação do documento de cobrança fora do prazo previsto nesta cláusula poderá implicar em sua rejeição e no direito do BNDES se ressarcir, preferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, por qualquer penalidade tributária incidente pelo atraso.  Parágrafo Terceiro Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.  Parágrafo Quarto Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Quinto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. descrição detalhada do objeto executado e dos respectivos valores; V. período de referência da execução do objeto; VI. nome e número do CNPJ do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; VIII. nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; IX. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; X. CNPJ do tomador do serviço: 33.657.248/0001-89; XI. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF; XIII. número de inscrição do contribuinte individual válido junto ao INSS (NIT ou PIS/PASEP); e XIV. destaque das retenções tributárias aplicáveis, conforme estabelecido na DIF.  Parágrafo Sexto Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Em casos de dispensa ou benefício fiscal que implique em redução ou eliminação da retenção de tributos, o CONTRATADO fornecerá todos os documentos comprobatórios.  Parágrafo Sétimo Caso o CONTRATADO emita documento fiscal ou equivalente legal autorizado por Estado diferente daquele onde se localiza o estabelecimento do BNDES adquirente do bem e destinatário da cobrança, deverá considerar a condição de não contribuinte do BNDES na emissão da nota fiscal e no recolhimento do diferencial de alíquota do ICMS, se houver.  Parágrafo Oitavo O documento fiscal ou equivalente legal emitido pelo CONTRATADO deverá estar em conformidade com a legislação do Estado onde o CONTRATADO esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos, sob pena de devolução do documento e interrupção do prazo para pagamento.   Parágrafo Nono Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado.  Parágrafo Décimo Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Primeiro Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.  Parágrafo Décimo Segundo Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.  Parágrafo Décimo Terceiro Fica assegurado ao BNDES o direito de deduzir do pagamento devido ao CONTRATADO, por força deste Contrato ou de outro contrato mantido com o BNDES, o valor correspondente aos pagamentos efetuados a maior ou em duplicidade.').
contract_clause(contrato_ocs_344_2022, clausula_nona_equilibrio_economico_financeiro_do_contrato, 'CLÁUSULA NONA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO', 'Considerando o prazo de vigência do presente Contrato, não se admite reajuste ou repactuação de preços, devendo o CONTRATADO arcar com eventuais elevações dos custos decorrentes de fatores ordinários, tais como alterações de acordo ou convenção coletiva de trabalho.  Parágrafo Primeiro O BNDES e o CONTRATADO têm direito à revisão de preços, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, desde que ocorra fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. a revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO. Neste último caso, o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta e do momento do pedido da revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Segundo O CONTRATADO deverá solicitar a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador da revisão de preços ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador, para solicitar a revisão de preços; II. o BNDES deverá analisar o pedido de revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e III. caso o CONTRATADO não solicite a revisão de preços nos prazos fixados acima, não fará jus à mesma, operando-se a renúncia ao seu eventual direito.').
contract_clause(contrato_ocs_344_2022, clausula_decima_matriz_de_riscos, 'CLÁUSULA DÉCIMA – MATRIZ DE RISCOS', 'O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro É vedada a celebração de aditivos decorrentes de eventos supervenientes alocados, na Matriz de Riscos, como de responsabilidade do CONTRATADO.').
contract_clause(contrato_ocs_344_2022, clausula_decima_primeira_obrigações_do_contratado, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DO CONTRATADO', 'Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação e a ausência de impedimentos exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados; IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que venha a emitir em desacordo com a legislação aplicável. VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. permitir ao Banco Central do Brasil acesso a termos firmados, documentos e informações atinentes bens fornecidos, bem como às suas dependências, nos termos do § 1° do artigo 33 da Resolução CMN n° 4.557/2017; XII. apresentar, em até 10 dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XIII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo o CONTRATADO ser instado a intervir no processo;  XIV. fornecer bens novos, sem uso prévio, e entregá-los em suas embalagens originais de fábrica, devidamente lacradas, acompanhados de seus manuais de uso e instalação, estando acondicionados em meio adequado, de forma a permitir completa segurança durante o transporte e a impedir seu uso ou deterioração até a entrega;').
contract_clause(contrato_ocs_344_2022, clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, 'CLÁUSULA DÉCIMA SEGUNDA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES', 'O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar a Política para Transações com Partes Relacionadas e o Código de Ética do Sistema BNDES vigentes ao tempo da contratação, bem como a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).').
contract_clause(contrato_ocs_344_2022, clausula_decima_terceira_sigilo_das_informações, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES', 'Caso o CONTRATADO venha a ter acesso a dados, materiais, documentos e informações de natureza sigilosa, direta ou indiretamente, em decorrência da execução do objeto contratual, deverá manter o sigilo dos mesmos, bem como orientar os profissionais envolvidos a cumprir esta obrigação, respeitando-se as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES.    Parágrafo Único Assim que solicitado pelo Gestor do Contrato, o CONTRATADO deverá providenciar a assinatura, por seu representante legal e pelos profissionais que tiverem acesso a informações sigilosas, dos Termos de Confidencialidade a serem disponibilizados pelo BNDES.').
contract_clause(contrato_ocs_344_2022, clausula_decima_quarta_acesso_protecao_dados_pessoais, 'CLÁUSULA DÉCIMA QUARTA – ACESSO E PROTEÇÃO DE DADOS PESSOAIS As partes assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios físicos e digitais, devendo, para tanto, adotar medidas corretas de segurança sob o aspecto técnico, jurídico e administrativo, e observar que:   I. Eventual tratamento de dados em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei n° 13.709/2018 – Lei Geral de Proteção de Dados - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular;  II. O tratamento será limitado às atividades necessárias ao atingimento das finalidades contratuais e, caso seja necessário, ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória, observando-se que, em caso de necessidade de coleta de dados pessoais, esta será realizada mediante prévia aprovação do BNDES, responsabilizando-se o CONTRATADO por obter o consentimento dos titulares, salvo nos casos em que a legislação dispense tal medida; III. O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação ao tratamento de dados pessoais; IV. O CONTRATADO se responsabilizará como “Controlador de dados” no caso do tratamento de dados para o cumprimento de suas obrigações legais ou regulatórias, devendo obedecer aos parâmetros previstos na legislação; V. Os dados coletados somente poderão ser utilizados pelas partes, seus representantes, empregados e prestadores de serviços diretamente alocados na execução contratual, sendo que, em hipótese alguma, poderão ser compartilhados ou utilizados para outros fins, sem a prévia autorização do BNDES, ou caso haja alguma ordem judicial, observando-se as medidas legalmente previstas para tanto; VI. O CONTRATADO deve manter a confidencialidade dos dados pessoais obtidos em razão do presente contrato, devendo adotar as medidas técnicas e administrativas adequadas e necessárias, visando assegurar a proteção dos dados, nos termos do artigo 46 da LGPD, de modo a garantir um nível apropriado de segurança e a prevenção e mitigação de eventuais riscos; VII. Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, que utilizará recursos de segurança da informação e tecnologia adequados, inclusive quanto a mecanismos de detecção e prevenção de ataques cibernéticos e incidentes de segurança da informação; VIII. O CONTRATADO dará conhecimento formal para seus empregados e/ou prestadores de serviço acerca das disposições previstas nesta Cláusula e na Cláusula de Sigilo das Informações, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados; IX. O BNDES possui direito de regresso em face do CONTRATADO em razão de eventuais danos causados por este em decorrência do descumprimento das responsabilidades e obrigações previstas no âmbito deste contrato e da Lei Geral de Proteção de Dados Pessoais; X. O CONTRATADO deverá disponibilizar ao titular do dado um canal ou sistema em que seja garantida consulta facilitada e gratuita sobre a forma, a duração do tratamento e a integralidade de seus dados pessoais; XI. O CONTRATADO deverá informar imediatamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, seguindo as orientações fixadas pelo BNDES e pela legislação em vigor para o adequado endereçamento das demandas; XII. O CONTRATADO deverá manter registro de todas as operações de tratamento de dados pessoais que realizar no âmbito do Contrato disponibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do Relatório de Impacto de Dados Pessoais, disposto no artigo 5º, XVII, da Lei Geral de Proteção de Dados Pessoais; XIII. Qualquer incidente que implique em violação ou risco de violação ou vazamento de dados pessoais deverá ser prontamente comunicado ao BNDES, informando-se também todas as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada; XIV. Ao final da vigência do Contrato, o CONTRATADO deverá eliminar de sua base de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal.    Parágrafo Primeiro  As Partes reconhecem que, se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado “Controlador de Dados”, e o CONTRATADO “Operador” ou “Processador de Dados”, salvo nas situações expressas em contrário nesse Contrato. Contudo, caso o CONTRATADO descumpra as obrigações prevista na legislação de proteção de dados ou as instruções do BNDES, será equiparado a “Controlador de Dados”, inclusive para fins de sua responsabilização por eventuais danos causados.  Parágrafo Segundo Caso o CONTRATADO disponibilize dados de terceiros, além das obrigações no caput desta Cláusula, deve se responsabilizar por eventuais danos que o BNDES venha a sofrer em decorrência de uso indevido de dados pessoais por parte do CONTRATADO, sempre que ficar comprovado que houve falha de segurança técnica e administrativa, descumprimento de regras previstas na legislação de proteção à privacidade e dados pessoais, e das orientações do BNDES, sem prejuízo das penalidades deste contrato.  Parágrafo Terceiro A transferência internacional de dados deve se dar em caráter excepcional e na estrita observância da legislação, especialmente, dos artigos 33 a 36 da Lei n° 13.709/2018 e nos normativos do Banco Central do Brasil relativos ao processamento e armazenamento de dados das instituições financeiras, e dependerá de autorização prévia do BNDES ao CONTRATADO.  Parágrafo Quarto A assinatura deste Contrato importa na manifestação de inequívoco consentimento do titular, seja ele pessoa física direta ou indiretamente relacionada ao CONTRATADO, inclusive sócios, representantes legais, empregados, contratados e/ou terceirizados, quando for o caso, dos dados pessoais que tenham se tornados públicos como condição para participação na licitação e para contratação, para tratamento pelo BNDES, na forma da Lei nº 13.709/2018. Poderão ser solicitados pelo BNDES dados pessoais adicionais a fim de viabilizar o cumprimento de obrigação legal.  Parágrafo Quinto Os representantes legais signatários do presente autorizam a divulgação dos dados pessoais expressamente contidos nos documentos decorrentes do procedimento de licitação, tais como nome, CPF, e-mail, telefone e cargo, para fins de publicidade das contratações administrativas no site institucional do BNDES e em cumprimento à Lei nº 12.527/ 2011 (Lei de Acesso à Informação).  Parágrafo Sexto As partes comprometem-se a coletar o consentimento, quando necessário, conforme previsto na Lei no 13.709/2018 (Lei Geral de Proteção de Dados-LGPD), bem como informar os titulares dos dados pessoais mencionados no presente instrumento, para as finalidades descritas no parágrafo acima.', 'trecho_literal').
contract_clause(contrato_ocs_344_2022, clausula_decima_quinta_obrigacoes_bndes, 'CLÁUSULA DÉCIMA QUINTA – OBRIGAÇÕES DO BNDES Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, Fernanda Pereira Goulart, que atualmente exerce a função de Coordenador de Serviços da ATI/DESET/GEAT, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. designar, como substituto do Gestor do Contrato, para atuar em sua eventual ausência, quem a estiver substituindo na função; IV. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; V. designar a Comissão de Recebimento, a quem caberá o recebimento do objeto, em conjunto com o Gestor do Contrato;  VI. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, acesso ao Código de Ética do Sistema BNDES, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VII. colocar à disposição do CONTRATADO todas as informações necessárias ao perfeito fornecimento dos bens objeto deste Contrato; e VIII. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.', 'trecho_literal').
contract_clause(contrato_ocs_344_2022, clausula_decima_sexta_equidade_genero_valorizacao_diversidade, 'CLÁUSULA DÉCIMA SEXTA – EQUIDADE DE GÊNERO E VALORIZAÇÃO DA DIVERSIDADE O CONTRATADO deverá comprovar, sempre que solicitado pelo BNDES, a inexistência de decisão administrativa final sancionadora, exarada por autoridade ou órgão competente, em razão da prática de atos, pelo próprio CONTRATADO ou dirigentes, administradores ou sócios majoritários, que importem em discriminação de raça ou gênero, trabalho infantil ou trabalho escravo, e de sentença condenatória transitada em julgado, proferida em decorrência dos referidos atos, e, se for o caso, de outros que caracterizem assédio moral ou sexual e importem em crime contra o meio ambiente.   Parágrafo Primeiro Na hipótese de ter havido decisão administrativa e/ou sentença condenatória, nos termos referidos no caput desta Cláusula, a execução do objeto contratual poderá ser suspensa pelo BNDES até a comprovação do cumprimento da reparação imposta ou da reabilitação do CONTRATADO ou de seus dirigentes, conforme o caso.  Parágrafo Segundo A comprovação a que se refere o caput desta Cláusula será realizada por meio de declaração, sem prejuízo da verificação do sistema informativo interno do BNDES – Sistema de Gerenciamento do Cadastro de Entidades (N02), acerca da inexistência de sanção em face do CONTRATADO e/ou de seus dirigentes, administradores ou sócios majoritários que impeça a contratação.', 'trecho_literal').
contract_clause(contrato_ocs_344_2022, clausula_decima_setima_cessao_contrato_credito_sucessao_contratual_subcontratacao, 'CLÁUSULA DÉCIMA SÉTIMA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO  É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.', 'trecho_literal').
contract_clause(contrato_ocs_344_2022, clausula_decima_oitava_penalidades, 'CLÁUSULA DÉCIMA OITAVA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa, de acordo com o Anexo I (Termo de Referência); e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades serão aplicadas observadas as normas do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer a reconsideração para a decisão de advertência, ou interpor o recurso cabível para as demais penalidades, na forma e no prazo previstos no Regulamento de Licitações e Contratos do SISTEMA BNDES.    Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto  A multa poderá ser aplicada juntamente com as demais penalidades.  Parágrafo Quinto  A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Sétimo A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de Licitações e Contratos do Sistema BNDES não importa em renúncia às penalidades prevista neste Contrato e no Anexo I (Termo de Referência).  Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_344_2022, clausula_decima_nona_alterações_contratuais, 'CLÁUSULA DÉCIMA NONA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.     Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento, os ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato e alterações de preços decorrentes decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_344_2022, clausula_vigésima_extinção_do_contrato, 'CLÁUSULA VIGÉSIMA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, e ainda: I. Consensualmente, formalizada em autorização escrita e fundamentada do BNDES, mediante aviso prévio por escrito, com antecedência mínima de 90 (noventa) dias ou de prazo menor a ser negociado pelas partes à época da rescisão; II. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; III. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; IV. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  V. quando for decretada a falência do CONTRATADO; VI. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VII. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VIII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  IX. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; X. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; XI. em razão da dissolução do CONTRATADO;  XII. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_344_2022, clausula_vigésima_primeira_disposições_finais, 'CLÁUSULA VIGÉSIMA PRIMEIRA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência Anexo II - Proposta Anexo III - Matriz de Risco Anexo IV - Termo de Confidencialidade para Representante Legal  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_344_2022, clausula_vigésima_segunda_foro, 'CLÁUSULA VIGÉSIMA SEGUNDA – FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.   As partes consideram, para todos os efeitos, a data da última assinatura digital como a data de formalização jurídica deste instrumento.  As folhas deste contrato foram conferidas por Marcio Oliveira da Rocha, advogado do BNDES, por autorização do representante legal que o assina.     _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES     _____________________________________________________________________ DADB EQUIPAMENTOS E SERVIÇOS DE INFORMÁTICA LTDA  Testemunhas:    __________________________________ __________________________________').

% ===== END =====
