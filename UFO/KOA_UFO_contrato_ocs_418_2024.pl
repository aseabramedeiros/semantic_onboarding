% ===== KOA Combined Output | contract_id: contrato_ocs_418_2024 =====

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
% UFO-only grounding generated from: KOA_Contrato_OCS_418_2024_-_SAP_BRASIL.pl
% contract_id: contrato_ocs_418_2024

instance_of(contrato_ocs_418_2024, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(sap_brasil_ltda, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_418_2024).
plays_role(sap_brasil_ltda, hired_service_provider_role, contrato_ocs_418_2024).

clause_of(clausula_primeira_objeto, contrato_ocs_418_2024).
clause_of(clausula_segunda_vigencia, contrato_ocs_418_2024).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_418_2024).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_418_2024).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_418_2024).
clause_of(clausula_sexta_preco, contrato_ocs_418_2024).
clause_of(clausula_setima_pagamento, contrato_ocs_418_2024).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_418_2024).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_418_2024).
clause_of(clausula_decima_primeira_obrigacoes_contratada, contrato_ocs_418_2024).
clause_of(clausula_decima_segunda_conduta_etica_contratada_bndes, contrato_ocs_418_2024).
clause_of(clausula_decima_terceira_sigilo_informacoes, contrato_ocs_418_2024).
clause_of(clausula_decima_quarta_obrigacoes_bndes, contrato_ocs_418_2024).
clause_of(clausula_decima_quinta_cessao_de_contrato_ou_de_credito_sucessao_contratual_e_subcontratacao, contrato_ocs_418_2024).
clause_of(clausula_decima_sexta_penalidades, contrato_ocs_418_2024).
clause_of(clausula_decima_setima_alteracoes_contratuais, contrato_ocs_418_2024).
clause_of(clausula_decima_oitava_extincao_do_contrato, contrato_ocs_418_2024).
clause_of(clausula_decima_nova_disposicoes_finais, contrato_ocs_418_2024).
clause_of(clausula_vigesima_foro, contrato_ocs_418_2024).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_418_2024).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, sap_brasil_ltda, provide_sap_enterprise_support).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_sap_enterprise_support).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, sap_brasil_ltda, communicate_non_renewal).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, sap_brasil_ltda, present_manifestation_about_renewal).
legal_relation_instance(clausula_segunda_vigencia, right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_signing_addendum).
legal_relation_instance(clausula_segunda_vigencia, subjection, sap_brasil_ltda, subject_to_penalties).
legal_relation_instance(clausula_segunda_vigencia, power, unknown, extend_contract).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, sap_brasil_ltda, execute_contract_according_to_specifications).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_execution_according_to_specifications).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, sap_brasil_ltda, execute_service_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_consequences_for_non_compliance).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_service_execution).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, sap_brasil_ltda, be_subject_to_consequences_for_non_compliance).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, efetuar_recebimento_objeto).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, efetuar_recebimento_objeto).
legal_relation_instance(clausula_quinta_recebimento_objeto, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, efetuar_recebimento_objeto).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_value).
legal_relation_instance(clausula_sexta_preco, right_to_action, sap_brasil_ltda, receive_contracted_value).
legal_relation_instance(clausula_sexta_preco, duty_to_act, sap_brasil_ltda, bear_quantification_errors).
legal_relation_instance(clausula_sexta_preco, subjection, sap_brasil_ltda, accept_price_reduction_for_partial_execution).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effectuate_payment).
legal_relation_instance(clausula_setima_pagamento, right_to_action, sap_brasil_ltda, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, sap_brasil_ltda, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_values).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, sap_brasil_ltda, issue_invoice_total_value).
legal_relation_instance(clausula_setima_pagamento, right_to_action, sap_brasil_ltda, emit_invoice_without_info).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, accept_invoice_without_info).
legal_relation_instance(clausula_setima_pagamento, subjection, sap_brasil_ltda, subject_to_tax_withholding).
legal_relation_instance(clausula_setima_pagamento, right_to_action, sap_brasil_ltda, receive_interest_for_delay).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, sap_brasil_ltda, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, sap_brasil_ltda, request_price_adjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, convene_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, sap_brasil_ltda, request_price_adjustment_or_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_request_price_adjustment_revision).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, sap_brasil_ltda, prestar_garantia_contratual).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, sap_brasil_ltda, complementar_ou_substituir_garantia).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, sap_brasil_ltda, obter_anuencia_do_garantidor).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, sap_brasil_ltda, obter_nova_garantia).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, prorrogar_prazo_apresentacao_garantia).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, prorrogar_prazo_nova_garantia).
legal_relation_instance(clausula_decima_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, aplicar_penalidade_por_descumprimento).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, sap_brasil_ltda, maintain_conditions_of_qualification).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, sap_brasil_ltda, report_impediment_to_contracting).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, sap_brasil_ltda, repair_defects).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, sap_brasil_ltda, repair_damages).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, sap_brasil_ltda, pay_charges_and_taxes).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, sap_brasil_ltda, allow_inspections).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, sap_brasil_ltda, obey_instructions).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, sap_brasil_ltda, designate_representative).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, sap_brasil_ltda, allow_access_to_central_bank).
legal_relation_instance(clausula_decima_primeira_obrigacoes_contratada, duty_to_act, sap_brasil_ltda, assist_contract_transition).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, sap_brasil_ltda, not_offer_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_omit, sap_brasil_ltda, offer_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, sap_brasil_ltda, prevent_favoritism).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_omit, sap_brasil_ltda, allow_favoritism).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, sap_brasil_ltda, not_allocate_family).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_omit, sap_brasil_ltda, allocate_family).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, sap_brasil_ltda, observe_ethics_code).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, sap_brasil_ltda, adopt_good_environmental_practice).
legal_relation_instance(clausula_decima_segunda_conduta_etica_contratada_bndes, duty_to_act, sap_brasil_ltda, remove_agents).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, sap_brasil_ltda, adopt_technical_measures).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_omit, sap_brasil_ltda, not_access_confidential_info).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, sap_brasil_ltda, maintain_secrecy_info).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, sap_brasil_ltda, limit_access_info).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, sap_brasil_ltda, inform_violation_rules).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, sap_brasil_ltda, deliver_material_bndes).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_omit, sap_brasil_ltda, not_use_confidential_info).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, duty_to_act, sap_brasil_ltda, observe_term_confidentiality).
legal_relation_instance(clausula_decima_terceira_sigilo_informacoes, right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, no_duty_to_allow_copying_info).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contratada).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_gestor_contrato).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_necessary_information).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alter_gestor_contrato).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions_and_procedures).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_administrative_procedure).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, right_to_action, sap_brasil_ltda, receive_payments_from_bndes).
legal_relation_instance(clausula_decima_quarta_obrigacoes_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_code_of_ethics).
legal_relation_instance(clausula_decima_quinta_cessao_de_contrato_ou_de_credito_sucessao_contratual_e_subcontratacao, duty_to_omit, sap_brasil_ltda, omit_contract_cession).
legal_relation_instance(clausula_decima_quinta_cessao_de_contrato_ou_de_credito_sucessao_contratual_e_subcontratacao, no_right_to_action, sap_brasil_ltda, no_right_contract_cession).
legal_relation_instance(clausula_decima_quinta_cessao_de_contrato_ou_de_credito_sucessao_contratual_e_subcontratacao, duty_to_omit, sap_brasil_ltda, omit_issue_credit_title).
legal_relation_instance(clausula_decima_quinta_cessao_de_contrato_ou_de_credito_sucessao_contratual_e_subcontratacao, no_right_to_action, sap_brasil_ltda, no_right_issue_credit_title).
legal_relation_instance(clausula_decima_quinta_cessao_de_contrato_ou_de_credito_sucessao_contratual_e_subcontratacao, duty_to_omit, sap_brasil_ltda, omit_subcontracting).
legal_relation_instance(clausula_decima_quinta_cessao_de_contrato_ou_de_credito_sucessao_contratual_e_subcontratacao, no_right_to_action, sap_brasil_ltda, no_right_subcontracting).
legal_relation_instance(clausula_decima_quinta_cessao_de_contrato_ou_de_credito_sucessao_contratual_e_subcontratacao, duty_to_omit, sap_brasil_ltda, omit_contractual_succession).
legal_relation_instance(clausula_decima_quinta_cessao_de_contrato_ou_de_credito_sucessao_contratual_e_subcontratacao, no_right_to_action, sap_brasil_ltda, no_right_contractual_succession).
legal_relation_instance(clausula_decima_quinta_cessao_de_contrato_ou_de_credito_sucessao_contratual_e_subcontratacao, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, analyze_risks_prejudices).
legal_relation_instance(clausula_decima_sexta_penalidades, subjection, sap_brasil_ltda, be_subject_to_penalties).
legal_relation_instance(clausula_decima_sexta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_penalties).
legal_relation_instance(clausula_decima_sexta_penalidades, subjection, sap_brasil_ltda, have_credits_deducted).
legal_relation_instance(clausula_decima_sexta_penalidades, duty_to_act, sap_brasil_ltda, present_defense).
legal_relation_instance(clausula_decima_sexta_penalidades, right_to_action, sap_brasil_ltda, present_defense_2).
legal_relation_instance(clausula_decima_sexta_penalidades, duty_to_act, sap_brasil_ltda, pay_fine).
legal_relation_instance(clausula_decima_sexta_penalidades, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extinguish_contract).
legal_relation_instance(clausula_decima_sexta_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extinguish_contract_2).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, nao_desnaturar_objeto).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalizar_alteracao_contratual).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, responder_por_danos).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, alterar_contrato).
legal_relation_instance(clausula_decima_setima_alteracoes_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, subject_to_formalize_contract_change).
legal_relation_instance(clausula_decima_oitava_extincao_do_contrato, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, notify_other_party).
legal_relation_instance(clausula_decima_oitava_extincao_do_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, resolve_contract).
legal_relation_instance(clausula_decima_oitava_extincao_do_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_insolvency).
legal_relation_instance(clausula_decima_oitava_extincao_do_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract).
legal_relation_instance(clausula_decima_oitava_extincao_do_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, suspend_contract_execution).
legal_relation_instance(clausula_decima_oitava_extincao_do_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_lesion).
legal_relation_instance(clausula_decima_oitava_extincao_do_contrato, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_dissolution).
legal_relation_instance(clausula_decima_oitava_extincao_do_contrato, right_to_omission, banco_nacional_de_desenvolvimento_economico_e_social_bndes, not_perform_contract).
legal_relation_instance(clausula_decima_nova_disposicoes_finais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights_any_time).
legal_relation_instance(clausula_decima_nova_disposicoes_finais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_strict_compliance_requirement).
legal_relation_instance(clausula_decima_nova_disposicoes_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, no_right_to_consider_omission_waiver).
legal_relation_instance(clausula_vigesima_foro, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, choose_rio_de_janeiro_court).
legal_relation_instance(clausula_vigesima_foro, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, choose_different_court).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, sap_brasil_ltda, omit_celebration_of_additives_for_allocated_events).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_celebration_of_additives_for_allocated_events).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, sap_brasil_ltda, right_to_celebrate_additives_for_allocated_events).
legal_relation_instance(clausula_nona_matriz_riscos, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_to_celebrate_additives_for_allocated_events).

% --- Action catalog (local to this contract grounding) ---
action_type(accept_invoice_without_info).
action_label(accept_invoice_without_info, 'Accept invoice without info').
action_type(accept_price_reduction_for_partial_execution).
action_label(accept_price_reduction_for_partial_execution, 'Accept price reduction for partial execution').
action_type(adopt_good_environmental_practice).
action_label(adopt_good_environmental_practice, 'Adopt good environmental practice').
action_type(adopt_technical_measures).
action_label(adopt_technical_measures, 'Adopt technical measures').
action_type(allocate_family).
action_label(allocate_family, 'Allocate family').
action_type(allow_access_to_central_bank).
action_label(allow_access_to_central_bank, 'Allow access to Central Bank').
action_type(allow_favoritism).
action_label(allow_favoritism, 'Allow favoritism').
action_type(allow_inspections).
action_label(allow_inspections, 'Allow inspections').
action_type(alter_gestor_contrato).
action_label(alter_gestor_contrato, 'Alter contract manager').
action_type(alterar_contrato).
action_label(alterar_contrato, 'Alter contract').
action_type(analyze_request_price_adjustment_revision).
action_label(analyze_request_price_adjustment_revision, 'Analyze request for price adjustment/revision').
action_type(analyze_risks_prejudices).
action_label(analyze_risks_prejudices, 'Analyze risks/prejudices').
action_type(aplicar_penalidade_por_descumprimento).
action_label(aplicar_penalidade_por_descumprimento, 'Apply penalty for non-compliance').
action_type(apply_consequences_for_non_compliance).
action_label(apply_consequences_for_non_compliance, 'Apply consequences for non-compliance').
action_type(apply_penalties).
action_label(apply_penalties, 'Apply penalties').
action_type(assist_contract_transition).
action_label(assist_contract_transition, 'Assist contract transition').
action_type(be_subject_to_consequences_for_non_compliance).
action_label(be_subject_to_consequences_for_non_compliance, 'Subject to consequences for non-compliance').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(bear_quantification_errors).
action_label(bear_quantification_errors, 'Bear quantification errors').
action_type(choose_different_court).
action_label(choose_different_court, 'Choose a different court.').
action_type(choose_rio_de_janeiro_court).
action_label(choose_rio_de_janeiro_court, 'Choose Rio court.').
action_type(communicate_administrative_procedure).
action_label(communicate_administrative_procedure, 'Communicate procedure opening').
action_type(communicate_instructions_and_procedures).
action_label(communicate_instructions_and_procedures, 'Communicate instructions').
action_type(communicate_non_renewal).
action_label(communicate_non_renewal, 'Communicate non-renewal').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalty').
action_type(complementar_ou_substituir_garantia).
action_label(complementar_ou_substituir_garantia, 'Supplement/replace guarantee').
action_type(comply_with_security_norms).
action_label(comply_with_security_norms, 'Comply with security norms').
action_type(convene_price_reduction).
action_label(convene_price_reduction, 'Convene price reduction').
action_type(deduct_values).
action_label(deduct_values, 'Deduct values').
action_type(deliver_material_bndes).
action_label(deliver_material_bndes, 'Deliver material to BNDES').
action_type(designate_gestor_contrato).
action_label(designate_gestor_contrato, 'Designate contract manager').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(efetuar_recebimento_objeto).
action_label(efetuar_recebimento_objeto, 'Receive the object').
action_type(effectuate_payment).
action_label(effectuate_payment, 'Effectuate payment').
action_type(emit_invoice_without_info).
action_label(emit_invoice_without_info, 'Emit invoice without info').
action_type(ensure_data_protection_compliance).
action_label(ensure_data_protection_compliance, 'Ensure data protection compliance').
action_type(execute_contract_according_to_specifications).
action_label(execute_contract_according_to_specifications, 'Execute contract as specified').
action_type(execute_service_according_to_standards).
action_label(execute_service_according_to_standards, 'Execute service as agreed').
action_type(exercise_rights_any_time).
action_label(exercise_rights_any_time, 'Exercise rights anytime').
action_type(expect_execution_according_to_specifications).
action_label(expect_execution_according_to_specifications, 'Expect execution as specified').
action_type(expect_service_execution).
action_label(expect_service_execution, 'Expect service as agreed').
action_type(extend_contract).
action_label(extend_contract, 'Extend contract').
action_type(extinguish_contract).
action_label(extinguish_contract, 'Extinguish contract').
action_type(extinguish_contract_2).
action_label(extinguish_contract_2, 'Extinguish contract').
action_type(formalizar_alteracao_contratual).
action_label(formalizar_alteracao_contratual, 'Formalize contract change').
action_type(guarantee_no_copyright_infringement).
action_label(guarantee_no_copyright_infringement, 'Guarantee no copyright infringement').
action_type(have_credits_deducted).
action_label(have_credits_deducted, 'Have credits deducted').
action_type(inform_violation_rules).
action_label(inform_violation_rules, 'Inform violation of rules').
action_type(issue_invoice_total_value).
action_label(issue_invoice_total_value, 'Issue invoice total value').
action_type(limit_access_info).
action_label(limit_access_info, 'Limit access to info').
action_type(maintain_conditions_of_qualification).
action_label(maintain_conditions_of_qualification, 'Maintain qualification conditions').
action_type(maintain_secrecy_info).
action_label(maintain_secrecy_info, 'Maintain secrecy of info').
action_type(make_payments_to_contratada).
action_label(make_payments_to_contratada, 'Make payments to Contratada').
action_type(nao_desnaturar_objeto).
action_label(nao_desnaturar_objeto, 'Do not change the object').
action_type(no_duty_to_allow_copying_info).
action_label(no_duty_to_allow_copying_info, 'No duty to allow copying').
action_type(no_right_contract_cession).
action_label(no_right_contract_cession, 'No right to contract cession').
action_type(no_right_contractual_succession).
action_label(no_right_contractual_succession, 'No right to contractual succession').
action_type(no_right_issue_credit_title).
action_label(no_right_issue_credit_title, 'No right to issue credit title').
action_type(no_right_subcontracting).
action_label(no_right_subcontracting, 'No right to subcontracting').
action_type(no_right_to_consider_omission_waiver).
action_label(no_right_to_consider_omission_waiver, 'No right to consider omission waiver').
action_type(not_access_confidential_info).
action_label(not_access_confidential_info, 'Not access confidential info').
action_type(not_allocate_family).
action_label(not_allocate_family, 'Not allocate family').
action_type(not_offer_undue_advantage).
action_label(not_offer_undue_advantage, 'Not offer undue advantage').
action_type(not_perform_contract).
action_label(not_perform_contract, 'Not perform contract').
action_type(not_use_confidential_info).
action_label(not_use_confidential_info, 'Not use confidential info').
action_type(notify_other_party).
action_label(notify_other_party, 'Notify other party').
action_type(obey_instructions).
action_label(obey_instructions, 'Obey instructions').
action_type(observe_ethics_code).
action_label(observe_ethics_code, 'Observe ethics code').
action_type(observe_term_confidentiality).
action_label(observe_term_confidentiality, 'Observe term of confidentiality').
action_type(obter_anuencia_do_garantidor).
action_label(obter_anuencia_do_garantidor, 'Obtain guarantor\'s consent').
action_type(obter_nova_garantia).
action_label(obter_nova_garantia, 'Obtain new guarantee').
action_type(offer_undue_advantage).
action_label(offer_undue_advantage, 'Offer undue advantage').
action_type(omit_celebration_of_additives_for_allocated_events).
action_label(omit_celebration_of_additives_for_allocated_events, 'Omit celebration of additives for allocated events').
action_type(omit_contract_cession).
action_label(omit_contract_cession, 'Omit contract cession').
action_type(omit_contractual_succession).
action_label(omit_contractual_succession, 'Omit contractual succession').
action_type(omit_issue_credit_title).
action_label(omit_issue_credit_title, 'Omit issuing credit title').
action_type(omit_signing_addendum).
action_label(omit_signing_addendum, 'Omit signing addendum').
action_type(omit_strict_compliance_requirement).
action_label(omit_strict_compliance_requirement, 'Omit strict compliance').
action_type(omit_subcontracting).
action_label(omit_subcontracting, 'Omit subcontracting').
action_type(pay_charges_and_taxes).
action_label(pay_charges_and_taxes, 'Pay taxes').
action_type(pay_contracted_value).
action_label(pay_contracted_value, 'Pay contracted value').
action_type(pay_fine).
action_label(pay_fine, 'Pay fine').
action_type(present_defense).
action_label(present_defense, 'Present defense').
action_type(present_defense_2).
action_label(present_defense_2, 'Present defense').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(present_manifestation_about_renewal).
action_label(present_manifestation_about_renewal, 'Present manifestation about renewal').
action_type(prestar_garantia_contratual).
action_label(prestar_garantia_contratual, 'Provide contractual guarantee').
action_type(prevent_favoritism).
action_label(prevent_favoritism, 'Prevent favoritism').
action_type(prorrogar_prazo_apresentacao_garantia).
action_label(prorrogar_prazo_apresentacao_garantia, 'Extend guarantee submission deadline').
action_type(prorrogar_prazo_nova_garantia).
action_label(prorrogar_prazo_nova_garantia, 'Extend new guarantee deadline').
action_type(provide_code_of_ethics).
action_label(provide_code_of_ethics, 'Provide code of ethics').
action_type(provide_necessary_information).
action_label(provide_necessary_information, 'Provide necessary information').
action_type(provide_sap_enterprise_support).
action_label(provide_sap_enterprise_support, 'Provide SAP enterprise support').
action_type(receive_contracted_value).
action_label(receive_contracted_value, 'Receive contracted value').
action_type(receive_interest_for_delay).
action_label(receive_interest_for_delay, 'Receive interest for delay').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payments_from_bndes).
action_label(receive_payments_from_bndes, 'Receive payments from BNDES').
action_type(receive_sap_enterprise_support).
action_label(receive_sap_enterprise_support, 'Receive SAP enterprise support').
action_type(remove_agents).
action_label(remove_agents, 'Remove agents').
action_type(repair_damages).
action_label(repair_damages, 'Repair damages').
action_type(repair_defects).
action_label(repair_defects, 'Repair defects').
action_type(report_impediment_to_contracting).
action_label(report_impediment_to_contracting, 'Report impediment to contracting').
action_type(request_price_adjustment).
action_label(request_price_adjustment, 'Request price adjustment').
action_type(request_price_adjustment_or_revision).
action_label(request_price_adjustment_or_revision, 'Request price adjustment/revision').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_proof_of_qualification).
action_label(request_proof_of_qualification, 'Request proof of qualification').
action_type(require_proof_of_tax_compliance).
action_label(require_proof_of_tax_compliance, 'Require proof of tax compliance').
action_type(resolve_contract).
action_label(resolve_contract, 'Resolve contract').
action_type(responder_por_danos).
action_label(responder_por_danos, 'Answer for damages').
action_type(return_resources).
action_label(return_resources, 'Return resources').
action_type(right_to_celebrate_additives_for_allocated_events).
action_label(right_to_celebrate_additives_for_allocated_events, 'No right to celebrate additives for allocated events').
action_type(subject_to_formalize_contract_change).
action_label(subject_to_formalize_contract_change, 'Subject to formalize change').
action_type(subject_to_penalties).
action_label(subject_to_penalties, 'Subject to penalties').
action_type(subject_to_tax_withholding).
action_label(subject_to_tax_withholding, 'Subject to tax withholding').
action_type(suspend_contract_execution).
action_label(suspend_contract_execution, 'Suspend contract execution').
action_type(terminate_contract).
action_label(terminate_contract, 'Terminate contract').
action_type(terminate_contract_due_dissolution).
action_label(terminate_contract_due_dissolution, 'Terminate contract due to dissolution').
action_type(terminate_contract_due_insolvency).
action_label(terminate_contract_due_insolvency, 'Terminate contract due to insolvency').
action_type(terminate_contract_due_lesion).
action_label(terminate_contract_due_lesion, 'Terminate contract due to lesion').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_418_2024).
contract_metadata(contrato_ocs_418_2024, numero_ocs, '418/2024').
contract_metadata(contrato_ocs_418_2024, numero_sap, '4400006197').
contract_metadata(contrato_ocs_418_2024, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_418_2024, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'SAP BRASIL LTDA.']).
contract_metadata(contrato_ocs_418_2024, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_418_2024, contratado, 'SAP BRASIL LTDA.').
contract_metadata(contrato_ocs_418_2024, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_418_2024, cnpj_contratado, '74.544.297/0001-92').
contract_metadata(contrato_ocs_418_2024, procedimento_licitatorio, 'Inexigibilidade de Licitação nº 056/2024').
contract_metadata(contrato_ocs_418_2024, data_autorizacao, '29/11/2024').
contract_metadata_raw(contrato_ocs_418_2024, 'ip_ati_desis4', '06/2024', 'trecho_literal').
contract_metadata(contrato_ocs_418_2024, data_ip_ati_degat, '27/11/2024').
contract_metadata(contrato_ocs_418_2024, rubrica_orcamentaria, '3101700021').
contract_metadata(contrato_ocs_418_2024, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_418_2024, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_418_2024, regulamento, 'Regulamento de Licitações e Contratos do Sistema BNDES').
contract_clause(contrato_ocs_418_2024, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação continuada do serviço de suporte SAP  Enterprise Support, conforme especificações constantes do Projeto Básico e também da Proposta, e respectivos anexos apresentados pela CONTRATADA, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_418_2024, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá duração de 12 (doze) meses, a contar da data de sua assinatura, podendo ser prorrogado, por períodos sucessivos, até o limite total de 36 (trinta e seis) meses.  Parágrafo Primeiro Até 90 (noventa) dias antes do término de cada período de vigência contratual, cabe à  CONTRATADA comunicar ao Gestor do Contrato, por escrito, o seu propósito de não prorrogar a vigência por um novo período, sob pena de se presumir a sua anuência em  celebrar o aditivo de prorrogação, nas mesmas condições então vigentes.  Parágrafo Segundo A CONTRATADA deverá, no prazo de até 5 (cinco) dias úteis, contados da notificação do Gestor do Contrato, apresentar, por intermédio do seu Representante Legal, sua manifestação sobre a prorrogação do Contrato.  Parágrafo Terceiro A formalização da prorrogação será efetuada por meio de aditivo epistolar, dispensando-se a assinatura da CONTRATADA.  Parágrafo Quarto Caso a CONTRATADA se recuse a celebrar aditivo contratual de prorrogação, tendo antes manifestado sua intenção de prorrogar o Contrato ou deixado de manifestar seu propósito de não prorrogar, nos termos do Parágrafo Primeiro desta Cláusula, ficará sujeito às penalidades previstas na Cláusula de Penalidades deste Contrato.').
contract_clause(contrato_ocs_418_2024, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Projeto Básico e da proposta apresentada pela CONTRATADA, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_418_2024, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'O serviço contratado deverá ser executado de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados na Proposta e respectivos anexos apresentados pela CONTRATADA e no Projeto Básico.  Parágrafo Único O descumprimento de qualquer meta de nível de serviço pactuada acarretará a aplicação das consequências previstas no Projeto Básico.').
contract_clause(contrato_ocs_418_2024, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor mencionado na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto na Proposta e respectivos anexos elaborados pela CONTRATADA e no Projeto Básico.').
contract_clause(contrato_ocs_418_2024, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará à CONTRATADA, pela execução do objeto contratado, o valor de R$ 6.795.624,00 (seis milhões, setecentos e noventa e cinco mil, seiscentos e vinte e quatro reais) (“Valor Global do Contrato”), conforme Proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.  Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato na data de celebração desse instrumento.  Parágrafo Segundo Na hipótese de o objeto ser, por culpa exclusiva da CONTRATADA, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis, se for o caso.  Parágrafo Terceiro A CONTRATADA deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua Proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua Proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_418_2024, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, no que se refere aos serviços de manutenção e suporte,  trimestralmente, e de modo postecipado (após a prestação do serviço), por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (como nota fiscal, fatura, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pela CONTRATADA, observado o disposto no Projeto Básico.   Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o 25 (vigésimo quinto) dia do mês seguinte.  Parágrafo Segundo O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia do último mês do trimestre, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia do respectivo trimestre. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia e último dia do referido trimestre. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.   Parágrafo Terceiro Para toda efetivação de pagamento, a CONTRATADA deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica nfe@bndes.gov.br do BNDES. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Quarto O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato. V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ da CONTRATADA, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente da CONTRATADA, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES; XI. CNPJ do tomador do serviço: 33.657.248/0001-89; XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XIII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento (DIF), bem como o código fiscal de operações e prestações (CFOP), se for o caso.  Parágrafo Quinto Na hipótese do gestor do contrato não comunicar a CONTRATADA das informações previstas nos incisos III e IV do parágrafo anterior com ao menos 10 (dez) dias anteriores a data de prevista para a emissão da respectiva Nota Fiscal/Fatura, a CONTRATADA poderá, e o BNDES deverá aceitar, emitir a referida Nota Fiscal/Fatura sem as mencionadas informações.  Parágrafo Sexto O documento fiscal ou equivalente legal emitido pela CONTRATADA deverá estar em conformidade com a legislação do Município onde a CONTRATADA esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos federais, sob pena de devolução do documento e interrupção do prazo para pagamento.  Parágrafo Sétimo Caso a CONTRATADA emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03.  A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pela CONTRATADA, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Oitavo Ao documento fiscal ou equivalente legal, deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que a CONTRATADA é optante do Simples Nacional, se for o caso;  III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; IV. demais documentos previstos no Plano de Trabalho.  Parágrafo Nono Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal à CONTRATADA ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que esta providencie as medidas saneadoras ou comprove a correção dos dados fundamentada e justificadamente contestados pelo BNDES.   Parágrafo Décimo Os pagamentos a serem efetuados em favor da CONTRATADA estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pela CONTRATADA.  Parágrafo Décimo Primeiro Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pela CONTRATADA. Em qualquer caso, a CONTRATADA emitirá o documento fiscal no valor total conforme Contrato.  Parágrafo Décimo Segundo Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível à CONTRATADA, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.').
contract_clause(contrato_ocs_418_2024, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e a CONTRATADA têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pela CONTRATADA a cada período de 12 (doze) meses, sendo o primeiro contado do dia 29/11/2024, data da apresentação da Proposta e respectivos anexos elaborados pela CONTRATADA, e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Custo de Tecnologia da Informação – ICTI, divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA, ou outro índice que vier a substituí-lo, sobre o preço referido na Cláusula de Preço deste Instrumento. Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação da CONTRATADA, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado à CONTRATADA ou ao BNDES nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. a CONTRATADA deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da Proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, a CONTRATADA deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da Proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado; IV. nos pedidos de revisão solicitados pelo BNDES, este deverá encaminhar correspondência à CONTRATADA, explicitando os motivos e comprovando o fato gerador e então facultar à CONTRATADA a apresentação de manifestação para demonstrar eventual descabimento da revisão pretendida pelo BNDES, para ser apreciada por este, exceto no caso de alteração das alíquotas dos tributos incidentes cuja aplicação prescindirá deste procedimento.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar a CONTRATADA para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na Proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo às partes procederem à negociação.   Parágrafo Quarto A CONTRATADA deverá solicitar o reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador do reajuste, ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pela CONTRATADA dos comprovantes de variação do índice de reajuste do Contrato ou variação dos custos ficando este prazo suspenso, a critério do BNDES, enquanto a CONTRATADA não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso a CONTRATADA não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.', 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO O BNDES e a CONTRATADA têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pela CONTRATADA a cada período de 12 (doze) meses, sendo o primeiro contado do dia 29/11/2024, data da apresentação da Proposta e respectivos anexos elaborados pela CONTRATADA, e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do Índice de Custo de Tecnologia da Informação – ICTI, divulgado pelo Instituto de Pesquisa Econômica Aplicada – IPEA, ou outro índice que vier a substituí-lo, sobre o preço referido na Cláusula de Preço deste Instrumento. Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação da CONTRATADA, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado à CONTRATADA ou ao BNDES nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte: I. a CONTRATADA deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da Proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, a CONTRATADA deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da Proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado; IV. nos pedidos de revisão solicitados pelo BNDES, este deverá encaminhar correspondência à CONTRATADA, explicitando os motivos e comprovando o fato gerador e então facultar à CONTRATADA a apresentação de manifestação para demonstrar eventual descabimento da revisão pretendida pelo BNDES, para ser apreciada por este, exceto no caso de alteração das alíquotas dos tributos incidentes cuja aplicação prescindirá deste procedimento.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar a CONTRATADA para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na Proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo às partes procederem à negociação.   Parágrafo Quarto A CONTRATADA deverá solicitar o reajuste e/ou a revisão de preços até a prorrogação ou o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias da prorrogação ou do encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a assinatura do aditivo de prorrogação torne superveniente a ocorrência do fato gerador do reajuste, ou a divulgação do índice de reajuste ocorra após a prorrogação ou o encerramento do Contrato, a CONTRATADA terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pela CONTRATADA dos comprovantes de variação do índice de reajuste do Contrato ou variação dos custos ficando este prazo suspenso, a critério do BNDES, enquanto a CONTRATADA não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso a CONTRATADA não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, não fará jus aos efeitos retroativos ou, caso o Contrato esteja encerrado, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.').
contract_clause(contrato_ocs_418_2024, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS O BNDES e a CONTRATADA, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos anexa a esse instrumento.  Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_418_2024, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL A CONTRATADA prestará garantia contratual, no prazo de até 30 (trinta) dias corridos, contados da assinatura deste Contrato, sob a pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para a sua aceitação estipuladas no Projeto Básico, no valor de R$ 135.912,48 (cento e trinta e cinco mil, novecentos e doze reais e quarenta e oito centavos), correspondente a 2% (dois por cento)  do valor do presente Contrato, que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia contratual poderá ser prorrogado, por igual período, quando solicitado pela CONTRATADA durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.   Parágrafo Segundo Em caso de alteração do valor contratual, prorrogação do prazo de vigência do Contrato, utilização total ou parcial da garantia pelo BNDES, ou em situações outras que impliquem em perda ou insuficiência da garantia, a CONTRATADA deverá providenciar a complementação ou substituição da garantia prestada no prazo determinado pelo BNDES ou pactuado em aditivo ou em apostilamento, observadas as condições originais para a aceitação da garantia estipuladas nesta Cláusula ou no Projeto Básico.  Parágrafo Terceiro Nos demais casos de alteração do Contrato, sempre que o mesmo for garantido por fiança bancária ou seguro garantia, a CONTRATADA deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 30 (trinta) dias corridos a contar da assinatura do aditivo ou recebimento da carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe à CONTRATADA obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.', 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL A CONTRATADA prestará garantia contratual, no prazo de até 30 (trinta) dias corridos, contados da assinatura deste Contrato, sob a pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para a sua aceitação estipuladas no Projeto Básico, no valor de R$ 135.912,48 (cento e trinta e cinco mil, novecentos e doze reais e quarenta e oito centavos), correspondente a 2% (dois por cento)  do valor do presente Contrato, que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia contratual poderá ser prorrogado, por igual período, quando solicitado pela CONTRATADA durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.   Parágrafo Segundo Em caso de alteração do valor contratual, prorrogação do prazo de vigência do Contrato, utilização total ou parcial da garantia pelo BNDES, ou em situações outras que impliquem em perda ou insuficiência da garantia, a CONTRATADA deverá providenciar a complementação ou substituição da garantia prestada no prazo determinado pelo BNDES ou pactuado em aditivo ou em apostilamento, observadas as condições originais para a aceitação da garantia estipuladas nesta Cláusula ou no Projeto Básico.  Parágrafo Terceiro Nos demais casos de alteração do Contrato, sempre que o mesmo for garantido por fiança bancária ou seguro garantia, a CONTRATADA deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 30 (trinta) dias corridos a contar da assinatura do aditivo ou recebimento da carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe à CONTRATADA obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.').
contract_clause(contrato_ocs_418_2024, clausula_decima_primeira_obrigacoes_contratada, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DA CONTRATADA Além de outras obrigações estabelecidas neste Instrumento, em seus anexos – especialmente o Anexo I – ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações da CONTRATADA: I. manter durante a vigência deste Contrato todas as condições de habilitação e qualificação exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a inexigibilidade de licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução, nos termos e forma do Projeto Básico; IV. reparar todos os danos diretos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir da CONTRATADA a comprovação de sua regularidade; VI. providenciar, perante a Receita Federal do Brasil – RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se a CONTRATADA, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das exceções previstas no artigo 17 da Lei Complementar nº 123/2006; VII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; VIII. obedecer às instruções e aos procedimentos estabelecidos pelo BNDES para a adequada execução do Contrato, quando este não estiver previsto no Contrato, no Projeto Básico, na Proposta e seus anexos; IX. designar 1 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor da CONTRATADA, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; X. permitir ao Banco Central do Brasil o acesso a este Contrato e seus anexos, a documentação e informações referentes aos serviços prestados e dependências da CONTRATADA, nos termos do § 1º do artigo 33 da Resolução CMN nº 4.557/2017 ou normativo que o suceda; XI. atender às solicitações do BNDES relativas à transição contratual entre a CONTRATADA e o seu sucessor na execução do serviço, prestando todo o suporte; XII. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, assegurando-se à CONTRATADA intervir no processo, pleitear a exclusão do BNDES do polo passivo e assumir a defesa;  XIII. responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos profissionais alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES;  XIV. devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao término da vigência do CONTRATO; e XV. assegurar que o objeto desta contratação seja prestado em consonância com as disposições da Lei Federal nº 13.709/2018 (Lei Geral de Proteção de Dados) e, considerando que a execução do objeto deste Contrato envolve, a princípio, o tratamento de dados pessoais, observar que:  i) caso haja alguma transferência e/ou tratamento de dados, a atividade deverá ser realizada nos termos da Lei Federal nº 13.709/2018 (Lei Geral de Proteção de Dados); e ii) caso haja alguma transferência e/ou tratamento de dados, a Contratada, na condição de operadora, executará suas atividades de acordo com o Contrato de Tratamento de Dados Pessoais para Serviços Profissionais e de Suporte, anexo à sua proposta técnica-comercial.  Parágrafo Primeiro  A responsabilidade civil da CONTRATADA em relação a este Contrato está limitada aos danos diretamente causados, até o Valor Global do Contrato e nenhuma das Partes será responsável por lucros cessantes e danos indiretos sofridos pela outra Parte. Parágrafo Segundo A limitação estabelecida no parágrafo primeiro não se aplica aos casos de: (i)            descumprimento de obrigações tributárias; (ii)          descumprimento de obrigações legais, regulamentares ou contratuais que resultem em violação de direitos relacionados a propriedade intelectual das partes ou de terceiros; (iii)         revelação dolosa de informações sigilosas, fraude ou má-fé, violação de leis ambientais, trabalhistas, previdenciárias, desde que haja nexo de causalidade com o dano; e (iv)         descumprimento do dever de reparar, corrigir, reconstruir ou substituir implementações que apresentem vícios, defeitos ou incorreções decorrentes da execução do contrato.', 'trecho_literal').
contract_clause(contrato_ocs_418_2024, clausula_decima_segunda_conduta_etica_contratada_bndes, 'CLÁUSULA DÉCIMA SEGUNDA – CONDUTA ÉTICA DA CONTRATADA E DO BNDES A CONTRATADA e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta em preceitos éticos e, em especial, na sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, a CONTRATADA obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau; IV. observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação, bem como a Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, à CONTRATADA, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete à CONTRATADA afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto A CONTRATADA declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).', 'trecho_literal').
contract_clause(contrato_ocs_418_2024, clausula_decima_terceira_sigilo_informacoes, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES Cabe à CONTRATADA cumprir as seguintes regras de sigilo e assegurar a aceitação e adesão às mesmas por profissionais que integrem ou venham a integrar a sua equipe na prestação do objeto deste Contrato, as quais perdurarão, inclusive, após a cessação do vínculo contratual e da prestação do serviço: I. adotar medidas técnicas para cumprir as diretrizes da Política Corporativa de Segurança da Informação do BNDES, no âmbito das atividades realizadas pela SAP com ativos de informação do BNDES no ambiente do Contratante. No ambiente da SAP, aplicar-se-ão as medidas técnicas e operacionais previstas no Anexo 2 ao Contrato de Tratamento de Dados para Serviços Profissionais e de Suporte da SAP, anexo à proposta técnica e comercial da SAP, em todo caso, sempre com o objetivo de garantir integridade, confidencialidade e disponibilidade dos ativos de informação do BNDES; II. não acessar informações sigilosas do BNDES, salvo quando previamente autorizado por escrito; III. sempre que tiver acesso às informações mencionadas no Inciso anterior: a) manter sigilo dessas informações, não podendo copiá-las, reproduzi-las, retê-las ou praticar qualquer outra forma de uso que não seja imprescindível para a adequada prestação do objeto deste Contrato; b) limitar o acesso às informações aos profissionais envolvidos na prestação do serviço objeto deste Contrato, os quais deverão estar cientes da natureza sigilosa das informações e das obrigações e responsabilidades decorrentes do uso dessas informações; e c) informar o mais brevemente possível ao BNDES qualquer violação das regras de sigilo ora estabelecidas que tenha ocorrido por sua ação ou omissão, independentemente da existência de dolo, bem como dos profissionais envolvidos, adotando todas as orientações do BNDES para remediar a violação; IV. entregar ao BNDES, ao término da vigência deste Contrato, todo e qualquer material de propriedade deste, inclusive notas pessoais envolvendo matéria sigilosa e registro de documentos de qualquer natureza que tenham sido criados, usados ou mantidos sob seu controle ou posse, assumindo o compromisso de não utilizar qualquer informação sigilosa a que teve acesso no âmbito deste Contrato; e V. observar o disposto no Termo de Confidencialidade assinado por seus representantes legais, anexo a este Contrato.', 'trecho_literal').
contract_clause(contrato_ocs_418_2024, clausula_decima_quarta_obrigacoes_bndes, 'CLÁUSULA DÉCIMA QUARTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis, vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos à CONTRATADA, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, o coordenador de serviços Luciano Junqueira Campos, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução do serviço, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas. O substituto do Gestor do Contrato será o analista de sistemas Gustavo Rezende Ferreira, em caso de ausência do Gestor do Contrato; III. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita à CONTRATADA;  IV. fornecer à CONTRATADA, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e Integridade no âmbito das licitações e contratos administrativos, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; V. colocar à disposição da CONTRATADA todas as informações necessárias à perfeita execução do serviço objeto deste Contrato; e VI. comunicar à CONTRATADA, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares da CONTRATADA, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_418_2024, clausula_decima_quinta_cessao_de_contrato_ou_de_credito_sucessao_contratual_e_subcontratacao, 'CLÁUSULA DÉCIMA QUINTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte da CONTRATADA, de qualquer título de crédito em razão do mesmo.   Parágrafo Primeiro  É vedada a sucessão contratual, salvo nas hipóteses em que a CONTRATADA realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais, previstos no Projeto Básico.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo jus, por conseguinte, ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É vedada a subcontratação para a execução do objeto deste Contrato.').
contract_clause(contrato_ocs_418_2024, clausula_decima_sexta_penalidades, 'CLÁUSULA DÉCIMA SEXTA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência razoável, devidamente justificada e fundamentada, expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal ou contratual, bem como em caso de mora, sem motivo justificado, a CONTRATADA ficará sujeita às penalidades: I. advertência; II. multa, nos casos, percentuais e limites estabelecidos no Projeto Básico; e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades indicadas nesta Cláusula somente poderão ser aplicadas após procedimento administrativo, e desde que assegurados o contraditório e a ampla defesa, facultada à CONTRATADA a defesa prévia, no prazo de 10 (dez) dias úteis.   Parágrafo Segundo Contra a decisão de aplicação de penalidade, a CONTRATADA poderá interpor o recurso cabível, na forma e no prazo previstos no Regulamento de Formalização, Execução e Fiscalização de Contratos Administrativos do Sistema BNDES.  Parágrafo Terceiro A imposição de sanção prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto A multa prevista nesta Cláusula poderá ser aplicada juntamente com as demais penalidades.   Parágrafo Quinto A multa aplicada e não paga tempestivamente pela CONTRATADA e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ela devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto No caso de uso indevido de informações sigilosas, observar-se-ão, no que couber, os termos da Lei nº 12.527/2011 e do Decreto nº 7.724/2012.  Parágrafo Sétimo No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Oitavo A sanção prevista no Inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da contratação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados devidamente comprovados mediante processo administrativo ou judicial.  Parágrafo Nono O total das multas aplicadas não poderá exceder a 20% (vinte por cento) do Valor Global do Contrato.').
contract_clause(contrato_ocs_418_2024, clausula_decima_setima_alteracoes_contratuais, 'CLÁUSULA DÉCIMA SÉTIMA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que: I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Projeto Básico.  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no Parágrafo anterior, deverá responder pelos danos diretos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.  Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento e os pequenos ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato, que poderão ser formalizados por meio epistolar.').
contract_clause(contrato_ocs_418_2024, clausula_decima_oitava_extincao_do_contrato, 'CLÁUSULA DÉCIMA OITAVA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, convencionando-se ainda, que é cabível a sua resolução: I. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo; IV. quando for decretada a falência da CONTRATADA; V. caso a CONTRATADA perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso a CONTRATADA seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VIII. em função da suspensão do direito de a CONTRATADA licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei n.º 12.846/2013, cometido pela CONTRATADA no processo de contratação ou por ocasião da execução contratual; X. em razão da dissolução da CONTRATADA; XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado, impeditivo da execução do Contrato; e. XII. em decorrência de inexecução injustificável do objeto do Contrato, apurada em processo administrativo com direito de defesa da CONTRATADA, nos termos do parágrafo primeiro da Cláusula Décima Sexta.  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 30 (trinta) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato e oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_418_2024, clausula_decima_nova_disposicoes_finais, 'CLÁUSULA DÉCIMA NOVA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram este Contrato o Projeto Básico, a Proposta e a Matriz de Risco, respectivamente, Anexos I, II e III ao presente Instrumento, no que com este não colidir, bem como com as disposições legais aplicáveis, observando-se que, ocorrendo conflitos de interpretação entre as disposições contratuais e de seus anexos, prevalecerá o disposto no Contrato e na legislação em vigor.  Parágrafo Segundo Caso haja contradição entre os termos da Proposta da CONTRATADA (Anexo II) e o Projeto Básico, (Anexo I), prevalecerá o estabelecido neste último.  Parágrafo Terceiro A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_418_2024, clausula_vigesima_foro, 'CLÁUSULA VIGÉSIMA – FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.   As folhas deste Contrato são conferidas por Márcio Oliveira da Rocha, advogado do BNDES, por autorização do representante legal que o assina.   E, por estarem assim justos e contratados, firmam o presente Instrumento, redigido em 1 (uma) via de igual teor e forma, para um só efeito, juntamente com as testemunhas abaixo.   Reputa-se celebrado o presente Contrato na última data em que for registrada a assinatura dos representantes legais do BNDES.     _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES     _____________________________________________________________________ SAP BRASIL LTDA  Testemunhas:   __________________________________    __________________________________').

% ===== END =====
